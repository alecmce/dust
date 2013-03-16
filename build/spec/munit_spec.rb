#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'

describe 'Unit-test runner' do

  subject do
    file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'example','config.yaml'))
    config = HaxeConfig.new file
    Munit.new(config)
  end

  it 'can determine that munit is not configured' do
    subject.is_configured?.should be_false
  end

  it 'can configure munit' do
    subject.configure
    subject.is_configured?.should be_true
  end

  it 'can clear configuration' do
    subject.configure
    subject.clear
    subject.is_configured?.should be_false
  end

end