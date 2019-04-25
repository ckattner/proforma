# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe ::Proforma::Compiling::Counter do
  specify '#ave returns 0 if count is 0' do
    expect(subject.ave).to eq(0)
  end
end
