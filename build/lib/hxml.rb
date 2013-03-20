#!/usr/bin/env ruby

class Hxml
  attr_reader :config

  def initialize(config)
    @config = config
  end

  def flash
    header = "-swf-header #{@config.width}:#{@config.height}:#{@config.fps}:#{@config.background}"
    compile 'swf', 'swf', header
  end

  def html5
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
      buffer << "-main #{@config.main}.hx"
      buffer << "-#{target} #{@config.bin}/#{@config.output}.#{path}"
      buffer << '-D haxe3' if @config.haxe == 3
      buffer << params unless params.nil?
      "haxe #{buffer.flatten.join(' ')}"
    end

end