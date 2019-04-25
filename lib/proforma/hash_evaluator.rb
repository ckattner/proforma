# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  # This class will serve as the evaluator that gets shipped with the base framework.
  # Other packages can extend or create their own and plug them into the rendering
  # pipeline.
  # This, being a prototype for customizable evaluators, just provides basic evaluation:
  # - it can only handle hashes for value extraction
  # - if text is prefixed with a dollar sign and colon then it means it will be dynamically
  #   evaluated against the record.  For example: $id
  class HashEvaluator
    PROPERTY_PREFIX = '$'

    def value(object, expression)
      return object if expression.to_s.empty?
      return nil    unless object.is_a?(Hash)

      object[expression.to_s] || object[expression.to_s.to_sym]
    end

    def text(object, expression)
      if expression.to_s.start_with?(PROPERTY_PREFIX)
        value(object, expression.to_s[PROPERTY_PREFIX.length..-1])
      else
        expression
      end
    end
  end
end
