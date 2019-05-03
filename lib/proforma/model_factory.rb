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
    acts_as_hashable_factory

    register 'Banner', Modeling::Banner

    register 'Collection', Modeling::Collection

    register 'DataTable', Modeling::DataTable

    register 'Grouping', Modeling::Grouping

    register 'Header', Modeling::Header

    register 'Pane', Modeling::Pane

    register 'Separator', Modeling::Separator

    register 'Spacer', Modeling::Spacer

    register 'Table', Modeling::Table

    register 'Text', Modeling::Text
  end
end
