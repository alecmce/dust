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
        openfl.clean 'ios'
    end
  end

  def make(target, flags = [])
    case target
      when 'flash'
        openfl.make 'flash', flags
      when 'html5', flags
        openfl.make 'html5', flags
        launch_html5 File.join(@root, 'bin', 'html5', 'bin', 'index.html')
      when 'iphone', flags
        openfl.make 'ios', flags
      when 'iphone_simulator'
        openfl.make 'ios', flags << '-simulator'
      when 'ipad'
        openfl.make 'ios', flags << '-ipad'
      when 'ipad_simulator'
        openfl.make 'ios', flags << '-ipad -simulator'
      else
        puts "dust unable to make #{target} - unsupported target"
    end
  end

  def update(target)
    case target
      when 'ipad'
        openfl.update 'ios', ' -ipad'
      when 'iphone_simulator'
        openfl.update 'ios', ' -simulator'
      when 'ipad_simulator'
        openfl.update 'ios', ' -simulator -ipad'
      else
        puts "dust unable to update #{target} - don't know what to do!"
    end
  end

  def build(target)
    case target
      when 'ipad'
        openfl.build 'ios', '-ipad'
      when 'iphone_simulator'
        openfl.build 'ios', ' -simulator'
      when 'ipad_simulator'
        openfl.build 'ios', '-simulator -ipad'
      else
        puts "dust unable to build #{target} - don't know what to do!"
    end
  end

  def run(target, flags = [])
    case target
      when 'flash'
        openfl.run 'flash', flags
      when 'html5'
        openfl.run 'html5'
      when 'ipad'
        openfl.test 'ios', flags << ' -ipad'
      when 'iphone_simulator'
        openfl.test 'ios', flags << ' -simulator'
      when 'ipad_simulator'
        openfl.test 'ios', flags << ' -simulator -ipad'
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

    def openfl
      @openfl ||= OpenFL.new @root, config, library
    end

    def launch_html5(path)
        system "open -a #{@config.get('html5', 'browser')} http://localhost:8000"
        system "http-server #{File.dirname(path)} -p 8000"
    end

    def system(command)
        puts "SYSTEM #{command}"
        `#{command}`
    end

end