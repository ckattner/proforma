# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Modeling
    # An object modeling of the notion of separation of two other models/sections.
    class Separator
      acts_as_hashable

      def initialize(*); end
    end
  end
end
