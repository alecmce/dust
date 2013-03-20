#!/usr/bin/env ruby

class Haxe
  attr_reader :config

  def initialize(config, haxelib)
    @config = config
    @haxelib = haxelib
    @libs = @config.libs.split(' ')
  end

  def verify_dependencies
    @libs.each do |name|
      thread = Thread.new do
        @haxelib.library(name).install
      end
      thread.join
    end
  end

  def flash
    @config.set_context('flash')
    verify_dependencies
    compile 'swf', 'swf', flash_dependencies
  end

    def flash_dependencies
      buffer = Array.new
      buffer << "-swf-header #{@config.width}:#{@config.height}:#{@config.fps}:#{@config.background}"
      buffer << "-swf-version #{@config.version}"
      buffer.join(' ')
    end

  def html5
    @config.set_config('html5')
    verify_dependencies
    compile 'js', 'html5'
  end

  def compile(target, path, params = nil)
    command = compile_command target, path, params
    `#{command}`
  end

  private

    def compile_command(target, path, params = nil)
      buffer = Array.new
      buffer << "-cp #{@config.src}"
      @libs.each do |lib|
        buffer << "-lib #{lib}"
      end
      buffer << "-main #{@config.main}.hx"
      buffer << "-#{target} #{@config.bin}/#{@config.output}.#{path}"
      buffer << '-D haxe3' if @config.haxe_version == 3
      buffer << params unless params.nil?
      "haxe #{buffer.flatten.join(' ')}"
    end

end