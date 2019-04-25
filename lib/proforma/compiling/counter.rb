# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Compiling
    # A counter is the actual underlying data structure for aggregation.
    class Counter
      attr_reader :count, :sum

      def initialize
        @count = 0
        @sum   = BigDecimal(0)
      end

      def add(value)
        parsed_value = value.to_s.empty? ? 0 : BigDecimal(value.to_s)

        @count += 1
        @sum   += parsed_value

        self
      end

      def ave
        return BigDecimal(0) if count.zero?

        sum / count
      end
    end
  end
end
