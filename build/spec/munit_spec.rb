#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'

describe 'Unit-test runner' do

  def root
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end

  subject do
    file = File.join(root, 'example', 'config.yaml')
    data = YAML.load_file file
    Munit.new(HaxeConfig.new(data), HaxeLibrary.new)
  end

  it 'creates output directories if needed' do
    dir = File.join(root, 'example', 'bin', 'test', 'bin')
    subject.ensure_directories
    File.exists?(dir).should be_true
  end

  it 'adds a browser flag when browser is configured' do
    subject.browser_flag.should == '-browser firefox'
  end

end