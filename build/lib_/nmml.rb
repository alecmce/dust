#!/usr/bin/env ruby

require 'erb'
require 'fileutils'

class Nmml

  TEMPLATE_FILE = File.expand_path(File.join(File.dirname(__FILE__), '..', 'assets', 'template.nmml.erb'))
  TARGET_FILE = 'build.nmml'

  def initialize(config)
    @config = config
  end

  def run(&block)
    make
    block.call
    delete
  end

  def make
    result = ERB.new(File.read(TEMPLATE_FILE)).result(@config.get_binding)
    File.open(target_hxml_file, 'w') do |file|
      file.write result
    end
  end

  def delete
    FileUtils.rm target_hxml_file
  end

  def target_hxml_file
    File.join Dir.pwd, TARGET_FILE
  end

end