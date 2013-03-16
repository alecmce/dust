#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'
require 'fileutils'

describe 'can build nme builds' do

  def dir
    File.join(File.dirname(File.dirname(__FILE__)), subject.config.bin)
  end

  subject do
    file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'example', 'config.yaml'))
    config = HaxeConfig.new file
    Nme.new(config)
  end

  before(:each) do
    FileUtils.mkdir_p dir unless File.exists? dir
  end

  after(:each) do
    FileUtils.rm_rf(dir) if File.exists? dir
  end

  it 'can build flash from nmml' do
    file = File.join(dir, 'flash', 'bin', 'output.swf')
    subject.publish 'flash'
    File.exists?(file).should be_true
  end

  it 'can build html5 from nmml' do
    file = File.join(dir, 'html5', 'bin', 'output.js')
    subject.publish 'html5'
    File.exists?(file).should be_true
  end

end