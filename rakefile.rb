#!/usr/bin/env ruby

HOME = File.dirname(__FILE__)

Dir[File.join(HOME, 'build/lib/*.rb')].each do |file|
  require file.chomp(File.extname(file))
end

file = File.join(HOME, 'config.yaml')
data = YAML.load_file file
config = HaxeConfig.new data
library = HaxeLibrary.new
munit = Munit.new HOME, config, library
haxe = Haxe.new HOME, config, library

task :default do
  puts 'hello, rake'
end

task :clean do
  munit.clean
end

namespace :test do

  task :reconfigure do
    puts munit.reconfigure
  end

  task :all => :build do
    puts munit.test %w(as3 js)
    #puts munit.test %w(as3 js cpp)
  end

  task :as3 do
    puts munit.test %w(as3)
  end

  task :html5 do
    puts munit.test %w(js)
  end

  task :cpp do
    puts 'munit does not fully support hxcpp yet'
    #puts munit.test %w(cpp)
  end

  task :build do
    puts `(cd build && bundle exec rspec --fail-fast)`
  end

end

namespace :make do

  task :gem do
    gem build './rbhaxe.gemspec'
  end

  task :flash do
    haxe.flash
  end

  task :html5 do
    haxe.html5
  end

end

namespace :run do

  task :flash => :'make:flash' do
    `open #{File.join(config.get('flash', 'bin'), "#{config.get('flash', 'output')}.swf")}`
  end

  task :html5 => :'make:html5' do

  end

end
