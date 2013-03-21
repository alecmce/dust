#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'
require 'fileutils'

describe 'can produce hxml commands' do

  subject do
    file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'example', 'config.yaml'))
    data = YAML.load_file file
    config = HaxeConfig.new data
    haxelib = HaxeLibrary.new
    Haxe.new config, haxelib
  end

  def dir
    File.join(File.dirname(File.dirname(__FILE__)), subject.config.get('default', 'bin'))
  end

  before(:each) do
    FileUtils.mkdir_p dir unless File.exists? dir
  end

  after(:each) do
    FileUtils.rm_rf(dir) if File.exists? dir
  end

  it 'publishes flash target' do
    file = File.join(dir, 'output.swf')
    subject.flash
    File.exists?(file).should be_true
  end

end