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
    subject.items['munit'].should be_an_instance_of HaxeLibraryItem
  end

  it 'versions each item' do
    subject.items['munit'].versions.should include '2.0.0'
  end

end