# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Modeling
    class Table
      # The lowest unit of a table.  Each row is comprised of zero or more cells.
      class Cell
        include Compiling::Compilable
        include Types::Align
        acts_as_hashable

        attr_writer :align, :text, :width

        def initialize(align: LEFT, text: '', width: nil)
          @align  = align
          @text   = text
          @width  = width
        end

        def align
          @align || LEFT
        end

        def text
          @text.to_s
        end

        def width
          @width ? @width.to_f : nil
        end

        def compile(data, evaluator)
          self.class.new(
            align: align,
            text: evaluator.text(data, text),
            width: width
          )
        end
      end
    end
  end
end
