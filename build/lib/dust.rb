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

  def clean(target)
    case target
      when 'tests'
        munit.clean
      when 'ios'
        nme.clean 'ios'
    end
  end

  def make(target, flags = [])
    case target
      when 'flash'
        nme.make 'flash', flags
      when 'html5', flags
        haxe.html5
      when 'iphone', flags
        nme.make 'ios', flags
      when 'iphone_simulator'
        flags << '-simulator'
        nme.make 'ios', flags
      when 'ipad'
        flags << '-ipad'
        nme.make 'ios', flags
      when 'ipad_simulator'
        flags << '-ipad -simulator'
        nme.make 'ios', flags
      else
        puts "dust unable to make #{target} - unsupported target"
    end
  end

  def update(target)
    case target
      when 'ipad'
        nme.update 'ios', '-ipad'
      when 'iphone_simulator'
        nme.update 'ios', '-simulator'
      when 'ipad_simulator'
        nme.update 'ios', '-simulator -ipad'
      else
        puts "dust unable to update #{target} - don't know what to do!"
    end
  end

  def build(target)
    case target
      when 'ipad'
        nme.build 'ios', '-ipad'
      when 'iphone_simulator'
        nme.build 'ios', '-simulator'
      when 'ipad_simulator'
        nme.build 'ios', '-simulator -ipad'
      else
        puts "dust unable to update #{target} - don't know what to do!"
    end
  end

  def run(target)
    case target
      when 'flash'
        nme.run 'flash'
      when 'html5'
        puts 'TODO running html5 target not implemented yet!'
      when 'ipad'
        nme.test 'ios', '-ipad'
      when 'iphone_simulator'
        nme.test 'ios', '-simulator'
      when 'ipad_simulator'
        nme.test 'ios', '-simulator -ipad'
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