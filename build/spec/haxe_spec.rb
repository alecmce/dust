#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'

describe "installs haxe" do

  subject do
    file = File.expand_path(File.join(File.dirname(__FILE__), '..', 'example','config.yaml'))
    config = HaxeConfig.new file
    Haxe.new config
  end

  it 'targets haxe 2.10 when version 2 is chosen' do
    subject.get_link.should == Haxe::VERSION_2_10
  end

  it 'makes required HAXE_BIN directory if missing' do
    File.directory?(File.expand_path(Haxe::HAXE_BIN)).should be_true
  end

  it 'downloads required zip if not present' do
    dir = File.join(subject.haxe_bin, 'haxe-2.10-osx')
    File.exists?(dir).should be_true
  end

end