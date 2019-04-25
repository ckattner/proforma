# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  # A rendering engine will output one or more of these objects. It is the final realization
  # of the compilation + rendering process.
  class Document
    acts_as_hashable

    attr_reader :contents, :extension, :title

    def initialize(contents: nil, extension: '', title: '')
      @contents   = contents
      @extension  = extension
      @title      = title

      freeze
    end

    def eql?(other)
      return false unless other.is_a?(self.class)

      contents == other.contents &&
        extension == other.extension &&
        title == other.title
    end

    def ==(other)
      eql?(other)
    end
  end
end
