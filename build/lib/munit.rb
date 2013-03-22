#!/usr/bin/env ruby

require 'fileutils'
require 'erb'

class Munit
  attr_reader :config

  TEMPLATE_HXML = File.expand_path(File.join(File.dirname(__FILE__), '..', 'assets', 'test.hxml.erb'))
  HXML_TARGET = 'test.hxml'

  def initialize(root, config, haxelib)
    @root = File.expand_path root
    @config = config
    @haxelib = haxelib
    require_munit
  end

    def require_munit
      munit = @haxelib.library('munit')
      munit.install unless munit.installed?
    end

  def test(types)
    reconfigure unless is_configured?
    verify_dependencies(types)
    execute types
  end

      def ensure_directory(path)
        FileUtils.mkdir_p path unless File.directory? path
      end

    def verify_dependencies(types)
      @config.libs(*types).each do |name|
        thread = Thread.new do
          puts "verify #{types} dependency -> '#{name}'"
          library = @haxelib.library name
          library.install unless library.nil? or library.installed?
        end
        thread.join
      end
    end

    def execute(types)
      buffer = ['run munit test']
      buffer << types.map { |type| "-#{type}" }
      buffer << browser_flag
      buffer << '-coverage' if @config.get_flag('testing', 'coverage')
      buffer << '--debug' if @config.get_flag('testing', 'debug')
      command = "haxelib #{buffer.flatten.join(' ').chomp}"
      puts command
      `#{command}`
    end

      def browser_flag
        browser = @config.get('testing', 'browser')
        browser.nil? ? '' : "-browser #{browser}"
      end

  def is_configured?
    config_file = expand '.munit'
    hxml_file = expand HXML_TARGET
    File.exists? config_file and File.exists? hxml_file
  end

  def reconfigure
    command = "(cd #{@root} && #{configure_command})"
    puts command
    `#{command}`
    write_test_hxml_template
  end

    def configure_command
      src = @config.get('default','src')
      test = @config.get('testing', 'src')
      bin = @config.get('testing','bin')
      report = @config.get('testing','report')
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
      hxml = expand HXML_TARGET
      FileUtils.rm hxml if File.exists? hxml
      File.open(TEMPLATE_HXML) do |template|
        erb = ERB.new template.read
        File.open(hxml, 'w') do |output|
          output.write erb.result(@config.get_binding)
        end
      end
    end

    def templates_dir
      templates = @config.get('testing','templates')
      templates.nil? ? 'build/assets/munit/' : templates
    end

      def expand(*dir)
        File.join @root, dir
      end

end