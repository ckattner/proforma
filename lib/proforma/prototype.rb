# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  # A prototype is a compiled template that has been flattened and ready for rendering.
  class Prototype
    attr_writer :children, :title

    def initialize(children: [], title: '')
      @children = ModelFactory.array(children)
      @title    = title
    end

    def children
      Array(@children)
    end

    def title
      @title.to_s
    end
  end
end
