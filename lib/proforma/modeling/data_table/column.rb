# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Modeling
    class DataTable
      # An explicit table column that understands how to compile header, body, and footer cells
      # from records.
      class Column
        include Modeling::Types::Align
        include Compiling::Compilable
        acts_as_hashable

        attr_writer :align,
                    :body,
                    :footer,
                    :header,
                    :width

        def initialize(
          align: LEFT,
          body: '',
          footer: '',
          header: '',
          width: nil
        )
          @align  = align
          @body   = body
          @footer = footer
          @header = header
          @width  = width
        end

        def align
          @align || LEFT
        end

        def body
          @body.to_s
        end

        def footer
          @footer.to_s
        end

        def header
          @header.to_s
        end

        def width
          @width ? @width.to_f : nil
        end

        def compile_header_cell(record, evaluator)
          Modeling::Table::Cell.new(
            align: align,
            text: evaluator.text(record, header),
            width: width
          )
        end

        def compile_body_cell(record, evaluator)
          Modeling::Table::Cell.new(
            align: align,
            text: evaluator.text(record, body),
            width: width
          )
        end

        def compile_footer_cell(record, evaluator)
          Modeling::Table::Cell.new(
            align: align,
            text: evaluator.text(record, footer),
            width: width
          )
        end

        def footer?
          !footer.to_s.empty?
        end

        def header?
          !header.to_s.empty?
        end
      end
    end
  end
end
