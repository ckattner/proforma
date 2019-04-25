# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Modeling
    class DataTable
      # An Aggregator is a table aggregator function configuration.
      class Aggregator
        acts_as_hashable

        module Function
          SUM = :sum
          AVE = :ave
        end
        include Function

        attr_accessor :property

        attr_writer :function, :name

        def initialize(function: SUM, name: '', property: nil)
          @function = function
          @name     = name
          @property = property
        end

        def function
          @function || SUM
        end

        def name
          @name.to_s
        end
      end
    end
  end
end
