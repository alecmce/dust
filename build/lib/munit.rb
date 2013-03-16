#!/usr/bin/env ruby

require 'fileutils'

class Munit

  def initialize(config)
    @config = config.testing
  end

  def test(types)
    ensure_directories
    execute_command types
  end

    def ensure_directories
      ensure_directory File.join(Dir.pwd, @config.bin)
      ensure_directory File.join(Dir.pwd, @config.report)
    end

      def ensure_directory(path)
        FileUtils.mkdir_p path unless File.directory? path
      end

    def execute_command(types)
      command = make_command types
      puts command
      puts `#{command}`
    end

    def make_command(types)
      buffer = []
      buffer << 'haxelib run munit test'
      buffer << types.map { |type| "-#{type}" }
      buffer << browser_flag
      buffer << coverage_flag
      buffer.join(' ')
    end

    def browser_flag
      @config.browser.nil? ? '' : "-browser #{@config.browser}"
    end

    def coverage_flag
      @config.coverage.nil? ? '' : '-coverage'
    end

end