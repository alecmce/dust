#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'
require 'fileutils'

describe 'can produce hxml commands' do

  subject do
    file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'example', 'config.yaml'))
    config = HaxeConfig.new file
    Hxml.new config
  end

  def dir
    File.join(File.dirname(File.dirname(__FILE__)), subject.config.bin)
  end

  before(:each) do
    FileUtils.mkdir_p dir unless File.exists? dir
  end

  after(:each) do
    FileUtils.rm_rf(dir) if File.exists? dir
  end

  it 'exposes the config' do
    subject.config.should be_a_kind_of HaxeConfig
  end

  it 'publishes flash target' do
    file = File.join(dir, 'output.swf')
    subject.flash
    File.exists?(file).should be_true
  end

end