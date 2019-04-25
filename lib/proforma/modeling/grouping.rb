# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Modeling
    # A grouping is an inverted collection, meaning, it iterates each child once per record
    # instead of only one time.  It also provides a mechanic to traverse data to tap
    # nested child data (through the property attribute.)
    class Grouping
      include Compiling::Compilable
      acts_as_hashable

      attr_accessor :property

      attr_writer :children

      def initialize(children: [], property: nil)
        @children = ModelFactory.array(children)
        @property = property
      end

      def children
        Array(@children)
      end

      def compile(data, evaluator)
        records = array(evaluator.value(data, property))

        records.map { |record| Collection.new(children: children).compile(record, evaluator) }
               .flatten
      end
    end
  end
end
