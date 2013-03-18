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

task :requirements do
  puts haxe.configuration_report unless haxe.is_configured?
end

task :default => :requirements do
  puts 'hello, rake'
end

task :clean do
  munit.clean
end

namespace :test do

  task :all => :requirements do
    puts munit.test %w(as3 js cpp)
  end

  task :as3 => :requirements do
    puts munit.test %w(as3)
  end

  task :js => :requirements do
    puts munit.test %w(js)
  end

  task :cpp => :requirements do
    puts munit.test %w(cpp)
  end

end
