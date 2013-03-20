#!/usr/bin/env ruby

HOME = File.dirname(__FILE__)

Dir[File.join(HOME, 'build/lib/*.rb')].each do |file|
  require file.chomp(File.extname(file))
end

path = File.join(HOME, 'config.yaml')
config = HaxeConfig.new path
haxelib = HaxeLibrary.new
munit = Munit.new config, haxelib
haxe = Haxe.new config, haxelib

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

  task :build do
    puts `(cd build && bundle exec rspec --fail-fast)`
  end

end

namespace :make do

  task :flash do
    haxe.flash
  end

  task :html5 do
    haxe.html5
  end

end

namespace :run do

  task :flash => :'make:flash' do
    target = File.join(config.bin, "#{config.output}.swf")
    `open #{target}`
  end

end
