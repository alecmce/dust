#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'
require 'fileutils'

describe 'can build nme builds' do

  subject do
    file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'example', 'config.yaml'))
    Nme.new(file)
  end

  before(:each) do
    @@dir = File.join(File.dirname(File.dirname(__FILE__)), subject.config.bin)
    FileUtils.mkdir_p @@dir unless File.exists? @@dir
  end

  after(:each) do
    FileUtils.rm_rf(@@dir) if File.exists? @@dir
  end

  it 'can build flash from nmml' do
    file = File.join(@@dir, 'flash', 'bin', 'output.swf')
    subject.publish 'flash'
    File.exists?(file).should be_true
  end

  it 'can build html5 from nmml' do
    subject.publish 'html5'
    true.should == false # this is not properly tested yet
  end

end