#!/usr/bin/env ruby

Dir[File.join(File.dirname(__FILE__), '..', 'lib/*.rb')].each do |file|
  require File.basename(file, File.extname(file))
end

require 'rspec'

describe 'config wraps a hash to expose config data' do

  it 'gets data by recursively inspecting hashes' do
    hash = {'first' => {'second' => 'data'}}
    config = HaxeConfig.new hash
    config.get('first', 'second').should == 'data'
  end

  it 'falls back to default values if lower-level config values are missing' do
    hash = {'default' => {'key' => 'value'}, 'flash' => {'koy' => 'typo!'}}
    config = HaxeConfig.new hash
    config.get('flash', 'key').should == 'value'
  end

  it 'gets all library dependencies for given contexts' do
    hash = {'default' => {'libs' => 'munit actuate'}, 'flash' => {'libs' => 'jeash'}}
    config = HaxeConfig.new hash
    config.get_list('flash', 'libs').should == %w(munit actuate jeash)
  end

end