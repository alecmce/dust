#!/usr/bin/env ruby

require 'fileutils'

class Munit
  attr_reader :config

  def initialize(config, haxelib)
    @config = config
    ensure_dependencies haxelib
  end

    def ensure_dependencies(haxelib)
      library = haxelib.library 'munit'
      library.install unless library.installed?
    end

  def test(types)
    ensure_directories
    execute types
  end

    def ensure_directories
      ensure_directory File.join(Dir.pwd, @config.get('testing', 'bin'))
      ensure_directory File.join(Dir.pwd, @config.get('testing', 'report'))
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
        `haxelib #{buffer.join(' ')}`
      end

        def browser_flag
          browser = @config.get('testing', 'browser')
          browser.nil? ? '' : "-browser #{browser}"
        end

        def coverage_flag
          coverage = @config.get('testing', 'coverage')
          coverage.nil? ? '' : '-coverage'
        end

  def configure_munit
    test = @config.get('testing', 'test')
    bin = @config.get('testing','bin')
    report = @config.get('testing','report')
    src = @config.get('testing','src')
    resources = @config.get('testing','resources')
    coverage = @config.get('testing','coverage')
    ignored = @config.get('testing','ignored')

    config.set_context('testing')
    buffer = ['haxelib run munit config']
    buffer << "-src #{expand test}"
    buffer << "-bin #{expand bin}"
    buffer << "-report #{expand report}"
    buffer << "-hxml #{expand 'test.hxml'}"
    buffer << "-classPaths #{expand src}"
    buffer << "-templates #{templates_dir}"
    buffer << "-resources #{expand resources}" unless resources.nil?
    buffer << "-coverage #{expand coverage}" unless coverage.nil?
    buffer << "-ignored #{expand ignored}" unless ignored.nil?
    `#{buffer.join(' ')}`
  end

    def templates_dir
      templates = @config.get('testing','templates')
      expand(templates.nil? ? 'build/assets/munit/' : templates)
    end

      def expand(dir)
        File.expand_path(File.join(File.dirname(__FILE__), dir))
      end

end