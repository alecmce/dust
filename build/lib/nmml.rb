#class Nmml
#
#  require 'builder'
#
#  def initialize(config, target, haxelib)
#    @config = config
#    @target = target
#    @haxelib = haxelib
#  end
#
#  def write
#    xml Builder::XmlMarkup.new(:indent => 2)
#    puts xml.project {
#      xml.meta {
#        xml.title = value_of('title')
#        xml.description = value_of('description')
#        xml.package = value_of('package')
#        xml.version = value_of('version')
#        xml.company = value_of('company')
#      }
#      xml.app {
#        xml.main = value_of('main')
#        xml.file = value_of('output')
#        xml.path = value_of('bin')
#        xml.preloader = value_of('preloader') unless value_of('reloader').nil?
#        xml.tag! 'swf-version', value_of('swf_version') if @target == 'flash'
#      }
#      xml.window {
#        xml.width = value_of('width')
#        xml.height = value_of('height')
#        xml.background = "0x#{value_of('background')}"
#        xml.fps = value_of('fps')
#        xml.orientation = value_of('orientation') unless value_of('orientation').nil?
#        xml.resizable = value_of('resizable') unless value_of('resizable').nil?
#        xml.borderless = value_of('borderless') unless value_of('borderless').nil?
#        xml.vsync = value_of('vsync') unless value_of('vsync').nil?
#        xml.fullscreen = value_of('fullscreen') unless value_of('fullscreen').nil?
#        xml.antialiasing = value_of('antialiasing') unless value_of('antialiasing').nil?
#      }
#      xml.source {
#        xml.path = value_of('src')
#      }
#
#      @config.libs(@target).each do |name|
#        thread = Thread.new do
#          puts "verify #{target} dependency -> '#{name}'"
#          library = @haxelib.library name
#          library.install unless library.nil? or library.installed?
#          xml << render()
#        end
#        thread.join
#      end
#
#        foo.bars.each do |bar|
#        xml << render(:partial => 'bar/_bar', :locals => { :bar => bar })
#      end
#
#        xml.widget {
#          xml.id 10
#          xml.name 'Awesome Widget'
#        }
#      }
#    }
#  end
#
#    def value_of(key)
#      @config.get(@target, key)
#    end
#
#end