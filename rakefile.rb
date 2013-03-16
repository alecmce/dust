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

task :test do
  munit.clear
  munit.configure
  munit.test %w(as3 js)
end