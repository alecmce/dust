#!/usr/bin/env ruby

class Dust
  attr_reader :root, :path

  def initialize(root, path)
    @root = root
    @path = path
  end

  def data
    @data ||= YAML.load_file File.expand_path(File.join(@root, @path))
  end

  def config
    @config ||= HaxeConfig.new data
  end

  def library
    @library  ||= HaxeLibrary.new
  end

  def reset_tests
    munit.reconfigure
  end

  def test(target)
    munit.test target
  end

  def make(target)
    case target
      when 'flash'
        nme.make 'flash'
      when 'html5'
        haxe.html5
      when 'iphone'
        nme.make 'ios'
      when 'iphone_simulator'
        nme.make 'ios', '-simulator'
      when 'ipad'
        nme.make 'ios', '-ipad'
      when 'ipad_simulator'
        nme.make 'ios', '-ipad -simulator'
      else
        puts "dust unable to make #{target} - unsupported target"
    end
  end

  def run(target)
    case target
      when 'flash'
        nme.run 'flash'
      when 'html5'
        puts 'TODO running html5 target not implemented yet!'
      when 'ipad'
        nme.run 'ios', '-ipad'
      when 'iphone_simulator'
        nme.run 'ios', '-simulator'
      when 'ipad_simulator'
        nme.run 'ios', '-simulator -ipad'
      else
        puts "dust unable to run #{target} - unsupported target"
    end
  end

  private

    def munit
      @munit ||= Munit.new @root, config, library
    end

    def haxe
      @haxe ||= Haxe.new @root, config, library
    end

    def nme
      @nme ||= Nme.new @root, config, library
    end

end