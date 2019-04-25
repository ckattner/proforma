# frozen_string_literal: true

#
# Copyright (c) 2018-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'yaml'

require 'pry'

require 'simplecov'
require 'simplecov-console'
SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start

require './lib/proforma'

def yaml_read(file)
  YAML.safe_load(File.open(file))
end

def fixture(file)
  File.open(File.join('spec', 'fixtures', file)).read
end
