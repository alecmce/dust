#!/usr/bin/env ruby

class Hxml
  attr_reader :config

  def initialize(config)
    @config = config
  end

  def publish_flash
    `#{compile_flash_command}`
  end

  def compile_flash_command
    params = ["-swf-header #{@config.width}:#{@config.height}:#{@config.fps}:#{@config.background}"]
    compile_command 'swf', 'swf', params
  end

  def compile_html5_command
    compile_command 'js', 'js'
  end

  def compile_command(target, file_type, extra_params = nil)
    params = []
    params << "-cp #{@config.src}"
    params << "-main #{@config.main}.hx"
    params << "-#{target} #{@config.bin}/#{@config.output}.#{file_type}"
    params << '-D haxe3' if @config.haxe == 3
    params << extra_params unless extra_params.nil?
    "haxe #{params.flatten.join(' ')}"
  end

end