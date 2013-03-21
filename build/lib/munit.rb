#!/usr/bin/env ruby

require 'fileutils'

class Munit
  attr_reader :config

  TEMPLATE_HXML = File.expand_path(File.join(File.dirname(__FILE__), '..', 'assets', 'test.hxml.erb'))
  HXML_TARGET = 'test.hxml'

  def initialize(root, config, haxelib)
    @root = File.expand_path root
    @config = config
    @haxelib = haxelib
    require_munit
    configure_munit unless is_configured?
  end

    def require_munit
      munit = @haxelib.library('munit')
      munit.install unless munit.installed?
    end

  def test(types)
    ensure_dependencies(types)
    execute types
  end

      def ensure_directory(path)
        FileUtils.mkdir_p path unless File.directory? path
      end

    def ensure_dependencies(types)
      @config.libs(*types).each do |name|
        library = @haxelib.library name
        library.install unless library.nil? or library.installed?
      end
    end

    def execute(types)
      buffer = ['run munit test']
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

  def is_configured?
    File.exists? expand('.munit')
  end

  def configure_munit
    `(cd #{@root} && #{configure_command})`
    write_test_hxml_template
  end

    def configure_command
      test = @config.get('testing', 'src')
      bin = @config.get('testing','bin')
      report = @config.get('testing','report')
      src = @config.get('testing','src')
      resources = @config.get('testing','resources')
      coverage = @config.get('testing','coverage')
      ignored = @config.get('testing','ignored')

      buffer = ['haxelib run munit config']
      buffer << "-src #{test}"
      buffer << "-bin #{bin}"
      buffer << "-report #{report}"
      buffer << "-hxml #{HXML_TARGET}"
      buffer << "-classPaths #{src}"
      buffer << "-templates #{templates_dir}"
      buffer << "-resources #{resources}" unless resources.nil?
      buffer << "-coverage #{coverage}" unless coverage.nil?
      buffer << "-ignored #{ignored}" unless ignored.nil?
      buffer.join(' ')
    end

    def write_test_hxml_template
      File.open(TEMPLATE_HXML) do |template|
        erb = ERB.new template.read
        File.open(expand(HXML_TARGET), 'w') do |output|
          output.write erb.result(@config.get_binding)
        end
      end
    end

    def templates_dir
      templates = @config.get('testing','templates')
      templates.nil? ? expand('..', 'assets/munit/') : templates
    end

      def expand(*dir)
        File.join @root, dir
      end

end