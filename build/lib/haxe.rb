#!/usr/bin/env ruby

class Haxe
  attr_reader :config

  def initialize(root, config, haxelib)
    @root = File.expand_path root
    @config = config
    @haxelib = haxelib
  end

  def verify_dependencies(target)
    @config.libs(target).each do |name|
      thread = Thread.new do
        puts "verify #{target} dependency -> '#{name}'"
        library = @haxelib.library name
        library.install unless library.nil? or library.installed?
      end
      thread.join
    end
  end

  def flash
    verify_dependencies 'flash'
    compile 'swf', 'swf', flash_parameters
  end

    def flash_parameters
      width = @config.get('flash', 'width')
      height = @config.get('flash', 'height')
      fps = @config.get('flash', 'fps')
      background = @config.get('flash', 'background')
      swf_version = @config.get('flash', 'swf_version')

      buffer = Array.new
      buffer << "-swf-header #{width}:#{height}:#{fps}:#{background}"
      buffer << "-swf-version #{swf_version}"
      buffer.join(' ')
    end

  def html5
    verify_dependencies 'html5'
    compile 'js', 'js'
  end

  def compile(target, path, params = nil)
    command = "(cd #{@root} && #{compile_command(target, path, params)})"
    puts command
    `#{command}`
  end

  private

    def compile_command(target, path, params = nil)
      src = @config.get(target, 'src')
      libs = @config.libs('default', target)
      main = @config.get(target, 'main')
      bin = @config.get(target, 'bin')
      output = @config.get(target, 'output')

      buffer = Array.new
      buffer << "-cp #{src}"
      libs.each do |lib|
        buffer << "-lib #{lib}"
      end
      buffer << "-main #{main}.hx"
      buffer << "-#{target} #{bin}/#{output}.#{path}"
      buffer << '-D haxe3' if @config.haxe == 3
      buffer << '-D HXCPP_M64' unless @config.get(target, '64bit').nil?
      buffer << '-debug' if @config.get(target, 'debug')
      buffer << params unless params.nil?
      "haxe #{buffer.flatten.join(' ')}"
    end

end