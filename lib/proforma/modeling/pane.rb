# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'pane/column'
require_relative 'pane/line'

module Proforma
  module Modeling
    # Think of a pane like a pivoted table.  It has columns but not in the same respect as
    # a table's columns.  For a pane, it makes up a vertical section.  Each column (section)
    # then has a number of lines which holds the label:value pairs that facilitates data
    # rendering.
    class Pane
      include Compiling::Compilable
      acts_as_hashable

      attr_writer :columns

      def initialize(columns: [])
        @columns = Column.array(columns)
      end

      def columns
        Array(@columns)
      end

      def compile(data, evaluator)
        compiled_columns = columns.map { |column| column.compile(data, evaluator) }

        self.class.new(columns: compiled_columns)
      end
    end
  end
end
