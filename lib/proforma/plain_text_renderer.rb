# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  # A basic rendering engine that will output plain-text.  It is meant to serve as
  # an example of how to create a rendering engine for this library.
  class PlainTextRenderer
    EXTENSION     = '.txt'
    RENDER_PREFIX = 'render_'

    private_constant :EXTENSION, :RENDER_PREFIX

    attr_reader :column_separator, :line_length, :pane_separator

    def initialize(column_separator: ', ', line_length: 40, pane_separator: ': ')
      @column_separator = column_separator.to_s
      @line_length      = line_length.to_i
      @pane_separator   = pane_separator.to_s
    end

    def render(prototype)
      @writer = StringIO.new

      prototype.children.each do |child|
        method_name = child_method_name(child)

        raise ArgumentError, "Cannot render: #{method_name}" unless respond_to?(method_name, true)

        send(method_name, child)
      end

      Document.new(
        contents: writer.string,
        extension: EXTENSION,
        title: prototype.title
      )
    end

    private

    attr_reader :writer

    def render_banner(banner)
      write_line(line('='))
      write_line(banner.title)
      write_line(line('='))
      write_line(banner.details)
      write_line(line('='))
    end

    def render_header(header)
      write_line(header.value.to_s.upcase)
    end

    def render_text(text)
      write_line(text.value)
    end

    def render_separator(_separator)
      write_line(line('-'))
    end

    def render_spacer(_separator)
      write_line
    end

    def render_table(table)
      write_section(table.header)
      write_section(table.body)
      write_section(table.footer)
    end

    def render_pane(pane)
      pane.columns.each do |column|
        column.lines.each do |line|
          write_line("#{line.label}#{pane_separator}#{line.value}")
        end
      end
    end

    def child_method_name(child)
      name = child.class.name.split('::').last.downcase
      "#{RENDER_PREFIX}#{name}"
    end

    def write_line(text = '')
      writer.puts(text)
    end

    def line(char)
      char * line_length
    end

    def write_section(section)
      section.rows.each do |row|
        write_line(row.cells.map(&:text).join(column_separator))
      end
    end
  end
end
