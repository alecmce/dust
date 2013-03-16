#!/usr/bin/env ruby

HOME = File.dirname(__FILE__)

Dir[File.join(HOME, 'build/lib/*.rb')].each do |file|
  require file.chomp(File.extname(file))
end

config = HaxeConfig.new(File.join(HOME, 'config.yaml'))
munit = Munit.new(config)
nmml = Nmml.new(config)

task :default do
  puts 'hello, rake'
end

task :clean do
  munit.clean
end

task :test do
  munit.test %w(as3 js cpp)
end

task :test_as3 do
  munit.test %w(as3)
end

task :test_js do
  munit.test %w(js)
end

task :test_cpp do
  munit.test %w(cpp)
end