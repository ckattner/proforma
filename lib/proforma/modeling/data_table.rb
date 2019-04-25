# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'data_table/aggregator'
require_relative 'data_table/column'

module Proforma
  module Modeling
    # A table that understands how to be compiled against a data source.
    class DataTable
      include Compiling::Compilable
      acts_as_hashable

      attr_accessor :property

      attr_writer :aggregators,
                  :columns,
                  :empty_message

      def initialize(
        aggregators: [],
        columns: [],
        empty_message: '',
        property: nil
      )
        @aggregators    = Aggregator.array(aggregators)
        @columns        = Column.array(columns)
        @empty_message  = empty_message
        @property       = property
      end

      def empty_message
        @empty_message.to_s
      end

      def aggregators
        Array(@aggregators)
      end

      def columns
        Array(@columns)
      end

      def compile(data, evaluator)
        records = array(evaluator.value(data, property))

        return Text.new(value: empty_message) if show_empty_message?(records)

        meta_data = make_aggregator_meta_data(records, evaluator)

        Table.new(
          body: make_body(records, evaluator),
          footer: make_footer(meta_data, evaluator),
          header: make_header({}, evaluator)
        )
      end

      private

      def make_aggregator_meta_data(records, evaluator)
        Compiling::Aggregation.new(aggregators, evaluator).add(records).to_h
      end

      def footer?
        columns.select(&:footer?).any?
      end

      def header?
        columns.select(&:header?).any?
      end

      def show_empty_message?(records)
        records.empty? && !empty_message.empty?
      end

      def make_footer(data, evaluator)
        make(footer?, :compile_footer_cell, data, evaluator)
      end

      def make_header(data, evaluator)
        make(header?, :compile_header_cell, data, evaluator)
      end

      def make(visible, row_compile_method, data, evaluator)
        return Table::Section.new unless visible

        rows = [
          make_row(row_compile_method, data, evaluator)
        ]

        Table::Section.new(rows: rows)
      end

      def make_body(records, evaluator)
        rows = records.map do |record|
          make_row(:compile_body_cell, record, evaluator)
        end

        Table::Section.new(rows: rows)
      end

      def make_row(method, record, evaluator)
        cells = columns.map do |column|
          column.send(method, record, evaluator)
        end

        Table::Row.new(cells: cells)
      end
    end
  end
end
