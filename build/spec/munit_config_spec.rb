#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'

describe 'munit config is configured from hash' do

  it 'can determine if a key is nil' do
    subject = MunitConfig.new({'aston'=>'villa'})
    subject.browser.should be_nil
  end

  it 'translates a string "nil" to nil' do
    subject = MunitConfig.new({'browser'=>'nil'})
    subject.browser.should be_nil
  end

  it 'a nil value is considered not defined' do
    subject = MunitConfig.new({'aston'=>'villa'})
    subject.is_defined?('browser').should be_false
  end

  it 'a non-nil value passed into get_optional is tracked' do
    subject = MunitConfig.new({'aston'=>'villa'})
    subject.get_optional('aston').should == 'villa'
  end

end