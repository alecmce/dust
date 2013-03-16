#!/usr/bin/env ruby

require 'fileutils'

class Munit

  HXML_TEMPLATE_FILE = File.expand_path(File.join(File.dirname(__FILE__), '..', 'assets', 'test.hxml.erb'))
  HXML_TARGET_FILE = 'test.hxml'

  TEMPLATE_FILE = File.expand_path(File.join(File.dirname(__FILE__), '..', 'assets', 'munit.erb'))
  TARGET_FILE = '.munit'

  def initialize(config)
    @config = config
  end

  def is_configured?
    File.exists? target_file
  end

  def configure
    write_munit unless is_configured?
  end

    def write_munit
      result = ERB.new(File.read(TEMPLATE_FILE)).result(@config.testing.get_binding)
      File.open(target_file, 'w') do |file|
        file.write result
      end
    end

      def target_file
        File.join Dir.pwd, TARGET_FILE
      end

  def clear
    FileUtils.rm target_file if is_configured?
  end


end

#def test_all
#  system 'haxelib run munit test -js -as3 -browser firefox'
#end
#
#def test_as3
#  system 'haxelib run munit test -as3 -browser firefox'
#end
#
#def test_js
#  system 'haxelib run munit test -js -browser firefox'
#end
#
#def test_cpp
#  system 'haxelib run munit test -cpp'
#end