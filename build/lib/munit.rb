#!/usr/bin/env ruby

require 'fileutils'

class Munit

  ASSETS_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..', 'assets'))
  TEMPLATE_FILE = File.join(ASSETS_DIR, 'munit.erb')
  TARGET_FILE = '.munit'

  def initialize(config)
    @config = config
  end

  def is_configured?
    File.exists? target_file
  end

  def configure
    unless is_configured?
      write_munit
      create_test_hxml
      copy_test_files
    end
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

    def create_test_hxml
      file = File.join Dir.pwd, 'test.hxml'
      FileUtils.touch file
    end

    def copy_test_files
      dir = File.join Dir.pwd, @config.testing.test
      FileUtils.cp File.join(ASSETS_DIR, 'TestMain.hx'), dir
      FileUtils.cp File.join(ASSETS_DIR, 'TestSuite.hx'), dir
    end

  def clear
    FileUtils.rm target_file if is_configured?
  end

  def test(types)
    params = types.map { |type| "-#{type}" }
    command = "haxelib run munit test #{params.join(' ')} #{browser_flag}"
    puts command
    `#{command}`
  end

    def browser_flag
      @config.testing.browser.nil? ? '' : "-browser #{@config.testing.browser}"
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