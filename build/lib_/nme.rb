#!/usr/bin/env ruby

require 'erb'
require 'fileutils'

class Nme
  attr_reader :config

  TEMPLATE_FILE = File.expand_path(File.join(File.dirname(__FILE__), '..', 'assets', 'template.nmml.erb'))
  TARGET_FILE = 'build.nmml'

  def initialize(config, haxe, nmml, haxelib)
    @config = config
    @haxe = haxe
    @nmml = nmml
    @haxelib = haxelib
  end

  def publish target
    @config.set_context(target)
    @nmml.run do
      `#{make_command target}`
    end
  end

  def make_command target
    list = Array.new
    list << "haxelib run nme update #{target_hxml_file} #{target}"
    list << "haxelib run nme build #{target_hxml_file} #{target}"
    list.join(' && ')
  end

  def write_nmml
    result = ERB.new(File.read(TEMPLATE_FILE)).result(@config.get_binding)
    File.open(target_hxml_file, 'w') do |file|
      file.write result
    end
  end

  def delete_nmml
    FileUtils.rm target_hxml_file
  end

  def target_hxml_file
    File.join Dir.pwd, TARGET_FILE
  end

end