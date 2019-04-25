# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  # A Template instance is a set of modeling objects with directions on how to compile it into
  # a Prototype object.  The prototype instance can then be rendered into an end-result such as
  # a text, pdf, or spreadsheet file.
  class Template < Prototype
    include Compiling::Compilable
    acts_as_hashable

    attr_writer :split

    def initialize(children: [], split: false, title: '')
      @split = split

      super(children: children, title: title)
    end

    def split
      @split || false
    end
    alias split? split

    def compile(data, evaluator)
      if split?
        compile_record(data, evaluator)
      else
        compile_collection(data, evaluator)
      end
    end

    private

    def compile_collection(data, evaluator)
      compiled_children = Modeling::Collection.new(children: children).compile(data, evaluator)

      [
        Prototype.new(
          children: compiled_children,
          title: evaluator.text({}, title)
        )
      ]
    end

    def compile_record(data, evaluator)
      default_grouping = Modeling::Grouping.new(children: children)

      array(data).map do |record|
        compiled_children = default_grouping.compile(record, evaluator)

        Prototype.new(
          children: compiled_children,
          title: evaluator.text(record, title)
        )
      end
    end
  end
end
