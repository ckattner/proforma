# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Modeling
    # This can be used as a super-class for models which are basically containers for
    # simple arrays of elements
    class GenericContainer
      def initialize(child_key, child_class, children = [])
        raise ArgumentError, 'child_key is required'   unless child_key
        raise ArgumentError, 'child_class is required' unless child_class

        @child_class = child_class
        @child_key   = child_key.to_s.to_sym
        @children    = child_class.array(children)
      end

      def respond_to_missing?(method_name, include_private = false)
        method_name.to_s == child_key.to_s ||
          method_name.to_s == child_setter_name ||
          super
      end

      def method_missing(method_name, *args, &block)
        if method_name.to_s == child_key.to_s
          Array(children)
        elsif method_name.to_s == child_setter_name
          @children = args
        else
          super
        end
      end

      def compile(data, evaluator)
        compiled_children = children.map { |child| child.compile(data, evaluator) }

        self.class.new(child_key => compiled_children)
      end

      private

      attr_reader :child_class, :child_key, :children

      def child_setter_name
        "#{child_key}="
      end
    end
  end
end
