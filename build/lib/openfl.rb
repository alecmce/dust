class OpenFL

  require 'builder'

  def initialize(root, config, haxelib)
    @root = root
    @config = config
    @haxelib = haxelib
  end

  def attributes_hash(attributes)
    hash = Hash.new()
    attributes.each do |node, key|
      value = value_of(key)
      hash[node] = value_of(key) unless value.nil?
    end
    hash
  end

  def make(target, flags)
    @target = target
    write_nmml
    if target == 'html5'
      build target, flags
    else
      test target, flags
    end
  end

  def clean(target)
    command = "openfl clean #{target}"
  end

  def test(target, flags)
    if is_defined('debug')
      flags << '-debug'
    end
    command = "openfl test #{target}.nmml #{target} #{flags.empty? ? '' : flags.join(" ")}"
    execute command
  end

  def update(target, flags)
    if is_defined('debug')
      flags << '-debug'
    end
    command = "openfl update #{target}.nmml #{target} #{flags.empty? ? '' : flags.join(" ")}"
    execute command
  end

  def build(target, flags)
    if is_defined('debug')
      flags << '-debug'
    end
    command = "openfl build #{target}.nmml #{target} #{flags.empty? ? '' : flags.join(" ")}"
    execute command
  end

  def run(target, flags)
    if is_defined('debug')
      flags << '-debug'
    end
    command = "openfl run #{target}.nmml #{target} #{flags.empty? ? '' : flags.join(" ")}"
    execute command
  end

  def write_nmml
    nmml = expand "#{@target}.nmml"
    File.open(nmml, 'w') do |output|
      output.write make_nmml
    end
  end

  # @see https://gist.github.com/alecmce/5223612
  def make_nmml

    meta = {}
    meta['title'] = value_of('title')
    meta['description'] = value_of('description')
    meta['package'] = value_of('package')
    meta['version'] = value_of('version')
    meta['company'] = value_of('company')

    app = {}
    app['main'] = value_of('main')
    app['file'] = value_of('output')
    app['path'] = value_of('bin')
    app['preloader'] = value_of('preloader') if is_defined('preloader')
    app['swf-version'] = value_of('swf_version') if @target == 'flash'

    window = {}
    window['width'] = value_of('width')
    window['height'] = value_of('height')
    window['background'] = "0x#{value_of('background')}"
    window['fps'] = value_of('fps')
    window['orientation'] = value_of('orientation') if is_defined('orientation')
    window['resizable'] = value_of('resizable') if is_defined('resizeable')
    window['borderless'] = value_of('borderless') if is_defined('borderless')
    window['vsync'] = value_of('vsync') if is_defined('vsync')
    window['fullscreen'] = value_of('fullscreen') if is_defined('fullscreen')
    window['antialiasing'] = value_of('antialiasing') if is_defined('antialiasing')
    window['depth-buffer'] = value_of('depth-buffer') if is_defined('depth-buffer')

    xml = Builder::XmlMarkup.new(:indent => 2)
    xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'
    xml.project {
      xml.meta meta
      xml.app app
      xml.window window
      xml.source :path => value_of('src')
      xml.icon :path => value_of('icon')

      list_of('libs').each do |name|
        xml.haxelib :name => name
      end

      list_of('ndlls').each do |ndll|
        xml.ndll :name => ndll
      end

      list_of('swf_lib').each do |swf|
        xml.compilerflag :name => "-swf-lib #{swf}"
      end

      list_of('assets').each do |path|
        xml.assets :path => path, :rename => File.basename(path)
      end

      if @target == 'flash' && is_defined('debug')
        xml.haxedef :name => 'fdb'
      end

      if @target == 'flash' && is_defined('telemetry')
        xml.haxedef :name => 'advanced-telemetry'
      end
    }
  end

  private

    def expand(*dir)
      File.join @root, dir
    end

    def value_of(key)
      @config.get(@target, key)
    end

    def is_defined(key)
      !@config.get(@target, key).nil?
    end

    def list_of(key)
      @config.get_list(@target, key)
    end

    def execute(command)
      $stdout.write "SYSTEM #{command}\n"
      $stdout.write `#{command}`
    end

end