# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe Proforma::Modeling::Table::Row do
  it 'should respond_to cells' do
    expect(subject.respond_to?(:cells)).to be true
  end

  it 'should respond_to cells=' do
    expect(subject.respond_to?('cells=')).to be true
  end

  it 'should not respond_to doesnt_exist' do
    expect(subject.respond_to?(:doesnt_exist)).to be false
  end

  describe '#method_missing' do
    it 'should get cells' do
      expect(subject.cells).to eq([])
    end

    it 'should set cells' do
      cell = Proforma::Modeling::Table::Cell.new

      subject.cells = cell

      expect(subject.cells).to eq([cell])
    end

    it 'should default to super' do
      expect { subject.doesnt_exist }.to raise_error(NoMethodError)
    end
  end
end
