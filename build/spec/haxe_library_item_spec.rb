#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'

describe 'models a haxelib library item' do

  before(:all) do
    `haxelib install munit 0.9.6`
    `haxelib install munit 2.0.2`
  end

  it 'should detect whether a library is installed' do
    subject = HaxeLibraryItem.new 'made_up'
    subject.installed?.should be_false
  end

  it 'detects whether a library is not installed' do
    subject = HaxeLibraryItem.new 'made_up'
    subject.installed?.should be_false
  end

  it 'installs a library' do
    subject = HaxeLibrary.new().library('random')
    subject.install
    subject.installed?.should be_true
  end

  it 'removes the library' do
    subject = HaxeLibrary.new().library('random')
    subject.install
    subject.remove
    subject.installed?.should be_false
  end

  it 'reports current version of installed library' do
    subject = HaxeLibraryItem.new 'munit', %w(0.9.6 2.0.2)
    subject.install
    subject.current_version.should_not be_nil
  end

  it 'reports current version as nil if library not installed' do
    subject = HaxeLibraryItem.new 'made_up'
    subject.current_version.should be_nil
  end

  # it 'allows library version to be swapped' do
  #   subject = HaxeLibraryItem.new 'munit'
  #   current = subject.current_version
  #   target = current == '2.0.2' ? '0.9.6' : '2.0.2'
  #   subject.set_version target
  #   subject.current_version.should == target
  #   subject.set_version current
  # end

  it 'returns most up-to-date version for a library' do
    subject = HaxeLibraryItem.new 'munit', ['0.9.6', '2.0.2', '0.1.0.0']
    subject.most_recent_version.should == '2.0.2'
  end

end