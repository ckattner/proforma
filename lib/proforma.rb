# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'acts_as_hashable'
require 'bigdecimal'
require 'forwardable'
require 'stringio'

require_relative 'proforma/compiling'
require_relative 'proforma/document'
require_relative 'proforma/hash_evaluator'
require_relative 'proforma/hash_refinements'
require_relative 'proforma/model_factory'
require_relative 'proforma/modeling'
require_relative 'proforma/plain_text_renderer'
require_relative 'proforma/prototype'
require_relative 'proforma/template'
require_relative 'proforma/type_factory'

# The top-level API that should be seen as the main entry point into this library.
module Proforma
  class << self
    def render(data, template, evaluator: HashEvaluator.new, renderer: PlainTextRenderer.new)
      Template.make(template)
              .compile(data, evaluator)
              .map { |prototype| renderer.render(prototype) }
    end
  end
end
