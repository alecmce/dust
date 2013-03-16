#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'

describe 'config is populated from target yaml' do

  subject do
    file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'example','config.yaml'))
    HaxeConfig.new file
  end

  it 'defines contexts based on the top-level configurations' do
    subject.default
  end

  it 'exposes a list of all the contexts' do
    subject.contexts.should =~ %w(default android ios webos)
  end

  it 'exposes has to query contexts' do
    subject.has?('webos').should be_true
  end

  it 'exposes all default properties' do
    subject.width.should == 800
  end

  it 'exposes contextual properties when context is changed' do
    subject.set_context('webos')
    subject.width.should == 200
  end

  it 'exposes default properties when context doesnt override' do
    subject.set_context('webos')
    subject.set_context('ios')
    subject.width.should == 800
  end

  it 'defines test configuration' do
    subject.testing.should be_an_instance_of(MunitConfig)
  end

end