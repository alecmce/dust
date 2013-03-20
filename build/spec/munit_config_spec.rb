#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'

describe 'munit config is configured from hash' do

  subject do
    file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'example', 'config.yaml'))
    config = HaxeConfig.new file
    config.testing
  end

  it 'parses values correctly' do
    subject.browser.should == 'firefox'
  end

  it 'parses "nil" string as nil' do
    subject.resources.should be_nil
  end

end