#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'
require 'fileutils'

describe 'can produce hxml commands' do

  subject do
    file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'example', 'config.yaml'))
    Hxml.new(file)
  end

  before(:each) do
    @@dir = File.join(File.dirname(File.dirname(__FILE__)), subject.config.bin)
    FileUtils.mkdir_p @@dir unless File.exists? @@dir
  end

  after(:each) do
    FileUtils.rm_rf(@@dir) if File.exists? @@dir
  end

  it 'exposes the config' do
    subject.config.should be_a_kind_of HaxeConfig
  end

  it 'can generate a Flash publish target' do
    expected = 'haxe -cp example/src -main Main.hx -swf example/bin/output.swf -swf-header 800:600:60:ffffff'
    subject.compile_flash_command.should == expected
  end

  it 'can generate an HTML5 publish target' do
    expected = 'haxe -cp example/src -main Main.hx -js example/bin/output.js'
    subject.compile_html5_command.should == expected
  end

  it 'can publish flash target' do
    file = File.join(@@dir, "output.swf")
    subject.publish_flash
    puts "#{file}"
    File.exists?(file).should be_true
  end

end