#!/usr/bin/env ruby

Dir.glob('lib/*.rb').each do |rb|
  require "#{rb}"
end

require 'rspec'

describe 'haxelib allows requirements to be defined in rake task' do

  subject do
    Haxelib.new()
  end

  context 'can require a library' do

    it 'can_install reports we can install minject' do
      subject.can_install('minject').should be_true
    end

    it 'retrieves a good url for minject' do
      subject.install_url('minject').should == 'http://lib.haxe.org/files/minject-1,1,0.zip'
    end

    it 'can install minject by name' do
      subject.install_library('minject').should be_true
    end

  end

end