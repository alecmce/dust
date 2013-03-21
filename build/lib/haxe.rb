#!/usr/bin/env ruby

class Haxe
  attr_reader :config

  def initialize(config, haxelib)
    @config = config
    @haxelib = haxelib
  end

  def verify_libs(target)
    @config.libs('default', target).each do |name|
      thread = Thread.new do
        @haxelib.library(name).install
      end
      thread.join
    end
  end

  def flash
    verify_libs 'flash'
    compile 'swf', 'swf', flash_parameters
  end

    def flash_parameters
      width = get_config('width')
      height = get_config('height')
      fps = get_config('fps')
      background = get_config('background')
      version = get_config('version')

      buffer = Array.new
      buffer << "-swf-header #{width}:#{height}:#{fps}:#{background}"
      buffer << "-swf-version #{version}"
      buffer.join(' ')
    end

  def html5
    verify_libs 'html5'
    compile 'js', 'js'
  end

  def compile(target, path, params = nil)
    command = compile_command target, path, params
    `#{command}`
  end

  private

    def get_config(key)
      @config.get('flash', key)
    end

    def compile_command(target, path, params = nil)
      src = get_config('src')
      libs = @config.libs('default', target)
      main = get_config('main')
      bin = get_config('bin')
      output = get_config('output')

      buffer = Array.new
      buffer << "-cp #{src}"
      libs.each do |lib|
        buffer << "-lib #{lib}"
      end
      buffer << "-main #{main}.hx"
      buffer << "-#{target} #{bin}/#{output}.#{path}"
      buffer << '-D haxe3' if @config.haxe == 3
      buffer << params unless params.nil?
      "haxe #{buffer.flatten.join(' ')}"
    end

end