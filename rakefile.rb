#!/usr/bin/env ruby

require 'fileutils'
require 'rubygems'
require 'zip/zip'

HOME = File.dirname(__FILE__)
Dir[File.join(HOME, 'build/lib/*.rb')].each do |file|
  require file.chomp(File.extname(file))
end

dust = Dust.new HOME, 'config.yaml'

task :clean do
  dust.munit.clean
end

namespace :test do

  task :reset do
    puts dust.reset_tests
  end

  task :all => [:build, :clients]

  task :clients do
    puts dust.test %w(as3 js cpp)
  end

  task :as3 do
    puts dust.test %w(as3)
  end

  task :html5 do
    puts dust.test %w(js)
  end

  task :cpp do
    puts munit.test %w(cpp)
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
    dust.make 'flash'
  end

  task :html5 do
    dust.make 'html5', ['-minify', '-yui']
  end

  task :iphone do
    dust.make 'iphone'
  end

  task :iphone_simulator do
    dust.make 'iphone_simulator'
  end

  task :ipad do
    dust.make 'ipad'
  end

  task :ipad_simulator do
    dust.make 'ipad_simulator'
  end

end

namespace :run do

  task :flash => :'make:flash' do
    dust.run 'flash'
  end

  task :html5 => :'make:html5' do

  end

  task :iphone => :'make:iphone' do
    dust.run 'ipad'
  end

  task :iphone_simulator => :'make:iphone_simulator' do
    dust.run 'iphone_simulator'
  end

  task :ipad => :'make:ipad' do
    dust.run 'ipad'
  end

  task :ipad_simulator => :'make:ipad_simulator' do
    dust.run 'ipad_simulator'
  end

end

namespace :fix do

  task :semicolons do
    
    previous_stderr, $stderr = $stderr, StringIO.new

    list = `rake make:flash 2>&1`.scan(/(.+?):([0-9]+): characters ([0-9]+)-([0-9]+) : Missing ;/)

    list.each do |fileName, lineNumber, startChar, endChar|
      lines = File.readlines(fileName)
      index = lineNumber.to_i - 1
      lines[index] = "#{lines[index].chomp};\n"
      File.open(fileName, "w") do |file|
        file.puts lines
      end
    end

    $stderr = previous_stderr

  end

end

namespace :haxelib do

  task :package do
    directory = File.join(HOME, 'src', '/')
    target = File.join(HOME, 'dust.zip')
    puts "create #{target}"
    FileUtils.rm target if File.exists? target
    Zip::ZipFile.open(target, Zip::ZipFile::CREATE) do |zipfile|
      Dir[File.join(directory, '**', '**')].each do |file|
        zipfile.add(file.sub(directory, ''), file)
      end
    end
  end

  task :local => :package do
    command = "haxelib remove dust"
    puts command
    `#{command}`
    command = "haxelib local #{File.join(HOME, 'dust.zip')}"
    puts command
    `#{command}`
  end

end