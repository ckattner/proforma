# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe Proforma::Modeling::Table::Cell do
  it 'should use defaults for all null attributes' do
    cell = described_class.new

    expect(cell.align).to eq(Proforma::Modeling::Types::Align::LEFT)
    expect(cell.text).to eq('')
    expect(cell.width).to be nil
  end

  it 'should parse width to float if value is not null' do
    expect(described_class.new(width: '34').width).to eq(34.0)
    expect(described_class.new(width: '').width).to eq(0)
    expect(described_class.new(width: '3a4').width).to eq(3.0)
  end
end
