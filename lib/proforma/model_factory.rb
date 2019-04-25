# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require_relative 'modeling'

module Proforma
  # This class serves as a singleton that can make Proforma::Modeling components.
  class ModelFactory
    REGISTRY = {
      'Banner': Modeling::Banner,
      'Collection': Modeling::Collection,
      'DataTable': Modeling::DataTable,
      'Grouping': Modeling::Grouping,
      'Header': Modeling::Header,
      'Pane': Modeling::Pane,
      'Separator': Modeling::Separator,
      'Spacer': Modeling::Spacer,
      'Table': Modeling::Table,
      'Text': Modeling::Text
    }.freeze

    class << self
      extend Forwardable

      def_delegators :factory, :array, :make

      private

      def factory
        @factory ||= TypeFactory.new(REGISTRY)
      end
    end
  end
end
