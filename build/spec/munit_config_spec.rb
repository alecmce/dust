#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'

describe 'munit config is configured from hash' do

  subject do
    file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'example', 'config.yaml'))
    config = HaxeConfig.new file
    haxe = Haxe.new config
    MunitConfig.new config, haxe
  end

  it 'can determine if a key is nil' do
    subject.browser.should be_nil
  end

  it 'translates a string "nil" to nil' do
    subject.browser.should be_nil
  end

  it 'a nil value is considered not defined' do
    subject.is_defined?('browser').should be_false
  end

  it 'a non-nil value passed into get_optional is tracked' do
    subject.get_optional('aston').should == 'villa'
  end

  it 'reads the version from haxelib version' do
    subject.version.should == '2.0.0'
  end

end