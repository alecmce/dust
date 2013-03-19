#!/usr/bin/env ruby

HOME = File.dirname(__FILE__)

Dir[File.join(HOME, 'build/lib/*.rb')].each do |file|
  require file.chomp(File.extname(file))
end

path = File.join(HOME, 'config.yaml')
config = HaxeConfig.new path
haxe = Haxe.new config
munit = Munit.new config, haxe
nmml = Nmml.new config

task :default do
  puts 'hello, rake'
end

task :clean do
  munit.clean
end

namespace :test do

  task :all do
    puts munit.test %w(as3 js cpp)
  end

  task :as3 do
    puts munit.test %w(as3)
  end

  task :js do
    puts munit.test %w(js)
  end

  task :cpp do
    puts munit.test %w(cpp)
  end

  test :build do
    puts `cd build; bundle exec rspec --fail-fast`
  end

end
