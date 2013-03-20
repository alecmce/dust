#!/usr/bin/env ruby

require 'open-uri'
require 'net/http'
require 'fileutils'

class HaxeFirewallWorkaround
  attr_reader :name, :library, :version

  HAXELIB_URL = 'http://lib.haxe.org/files/'

  def initialize(library, version = nil)
    @library = library
    @name = library.name
    @version = version.nil? ? library.most_recent_version : version
  end

  def install
    local = local_path
    download(remote_path, local) unless File.exists? local
    `haxelib test #{local}`
  end

    def download(remote, local)
      File.open(local, 'wb') do |write_file|
        open(remote) do |read_file|
          write_file.write(read_file.read)
        end
      end
    end

      def remote_path
        "#{HAXELIB_URL}#{@name}-#{version.gsub('.',',')}.zip"
      end

      def local_path
        File.join(zip_directory, "#{@name}.zip")
      end

        def zip_directory
          path = File.expand_path(File.join('~', 'haxe', 'zip'))
          FileUtils.mkdir_p path unless File.exists? path
          path
        end

end