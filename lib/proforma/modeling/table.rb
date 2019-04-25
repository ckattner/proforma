# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'table/cell'
require_relative 'table/row'
require_relative 'table/section'

module Proforma
  module Modeling
    # A basic table structure modeled off of an HTML table:
    # A table has three sections: header, body, footer.
    # Each section has rows.
    # Each row has cells.
    class Table
      acts_as_hashable

      attr_writer :body, :footer, :header

      def initialize(body: Section.new, footer: Section.new, header: Section.new)
        @body   = Section.make(body)
        @footer = Section.make(footer)
        @header = Section.make(header)
      end

      def body
        @body || Section.new
      end

      def footer
        @footer || Section.new
      end

      def header
        @header || Section.new
      end

      def compile(data, evaluator)
        self.class.new(
          body: body.compile(data, evaluator),
          footer: footer.compile(data, evaluator),
          header: header.compile(data, evaluator)
        )
      end
    end
  end
end
