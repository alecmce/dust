#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'

describe 'works around haxelib firewall problems' do

  subject do
    library = HaxeLibraryItem.new 'random', ['1.0.0.1', '1.1.0.0', '1.0.1.1']
    HaxeFirewallWorkaround.new library
  end

  it 'should specify a download directory in haxelib' do
    subject.zip_directory.should == File.expand_path(File.join('~', 'haxe', 'zip'))
  end

  it 'the directory should exist' do
    File.exists?(File.expand_path(File.join('~', 'haxe', 'zip')))
  end

  it 'should choose most recent version if no version is supplied' do
    subject.version.should == '1.1.0.0'
  end

  it 'should install random library' do
    `haxelib remove random`
    subject.install
    subject.library.current_version.should == '1.1.0.0'
  end

end