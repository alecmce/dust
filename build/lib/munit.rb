#!/usr/bin/env ruby

require 'fileutils'

class Munit
  attr_reader :config

  def initialize(config, haxe)
    @config = config.testing
    @haxe = haxe
  end

  def test(types)
    ensure_directories
    execute types
  end

    def ensure_directories
      ensure_directory File.join(Dir.pwd, @config.bin)
      ensure_directory File.join(Dir.pwd, @config.report)
    end

      def ensure_directory(path)
        FileUtils.mkdir_p path unless File.directory? path
      end

    def execute(types)
      buffer = []
      buffer << 'run munit test'
      buffer << types.map { |type| "-#{type}" }
      buffer << browser_flag
      buffer << coverage_flag
      @haxe.lib(buffer.join(' '))
    end

    def browser_flag
      @config.browser.nil? ? '' : "-browser #{@config.browser}"
    end

    def coverage_flag
      @config.coverage.nil? ? '' : '-coverage'
    end

end