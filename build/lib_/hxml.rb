#!/usr/bin/env ruby

class Hxml
  attr_reader :config

  def initialize(config, haxe)
    @config = config
    @haxe = haxe
  end

  def compile_flash
    params = ["-swf-header #{@config.width}:#{@config.height}:#{@config.fps}:#{@config.background}"]
    compile 'swf', 'swf', params
  end

  def compile_js
    compile 'js', 'js'
  end

  def compile(target, file_type, extra_params = nil)
    params = []
    params << "-cp #{@config.src}"
    params << "-main #{@config.main}.hx"
    params << "-#{target} #{@config.bin}/#{@config.output}.#{file_type}"
    params << '-D haxe3' if @config.haxe == 3
    params << extra_params unless extra_params.nil?
    @haxe.run(params.flatten.join(' '))
  end

end