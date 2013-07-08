#!/usr/bin/env ruby

require 'open-uri'
require 'net/http'
require 'fileutils'

class HaxeFirewallWorkaround
  attr_reader :name, :library, :version

  def initialize(library, version = nil)
    @library = library
    @name = library.name
    @version = version.nil? ? library.most_recent_version : version
  end

  def can_install?
    not @version.nil?
  end

  def install
    if (@version.nil?)
      raise "Missing version in HaxeFirewallWorkaround for library #{@name}"
    else
      local = local_path
      puts "#{remote_path} -> #{local_path}"
      download(remote_path, local) unless File.exists? local
      command = "yes | haxelib local #{local}"
      result = `#{command}`
      result.include? "Current version is now #{@version} Done"
    end
  end

    def download(remote, local)
      File.open(local, 'wb') do |write_file|
        open(remote) do |read_file|
          write_file.write(read_file.read)
        end
      end
    end

      def remote_path
        "#{HaxeLibrary::HAXELIB_URL}#{@name}-#{version.gsub('.',',')}.zip"
      end

      def local_path
        File.join(zip_directory, "#{@name}-#{@version}.zip")
      end

        def zip_directory
          path = File.expand_path(File.join('~', 'haxe', 'zip'))
          FileUtils.mkdir_p path unless File.exists? path
          path
        end

end