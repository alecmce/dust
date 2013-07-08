#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'

describe 'creates library items' do

  subject do
    HaxeLibrary.new
  end

  it 'creates item for each remote haxelib library' do
    subject.library('munit').should be_an_instance_of HaxeLibraryItem
  end

  it 'creates an item for made-up libraries' do
    subject.library('made_up').should be_an_instance_of HaxeLibraryItem
  end

  it 'versions each item' do
    subject.library('munit').versions.should include '2.0.2'
  end

  it 'detects whether a library is available' do
    subject.available?('munit').should be_true
  end

  it 'detects whether a library is unavailable' do
    subject.available?('made_up').should be_false
  end

end