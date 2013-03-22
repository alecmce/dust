#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'
require 'fileutils'

describe 'Unit-test runner' do

  def root
    File.expand_path(File.join(File.dirname(__FILE__), '..', 'example'))
  end

  subject do
    file = File.join(root, 'config.yaml')
    data = YAML.load_file file
    Munit.new(root, HaxeConfig.new(data), HaxeLibrary.new)
  end

  it 'adds a browser flag when browser is configured' do
    subject.browser_flag.should == '-browser firefox'
  end

  it 'configures .munit if not already configured' do
    munit_config = File.join(root, '.munit')
    FileUtils.rm munit_config if File.exists? munit_config
    subject.reconfigure
    File.exists?(munit_config).should be_true
  end

end