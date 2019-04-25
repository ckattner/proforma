# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe Proforma::HashEvaluator do
  let(:hash) { { id: 1, 'first' => 'Matt' } }

  describe '#value' do
    it 'should work with string keys' do
      expect(subject.value(hash, 'first')).to eq(hash['first'])
      expect(subject.value(hash, :first)).to  eq(hash['first'])
    end

    it 'should work with symbol keys' do
      expect(subject.value(hash, 'id')).to  eq(hash[:id])
      expect(subject.value(hash, :id)).to   eq(hash[:id])
    end
  end
end
