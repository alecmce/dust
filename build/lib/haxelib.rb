#!/usr/bin/env ruby

require 'open-uri'
require 'net/http'
require 'fileutils'

class Haxelib

  HAXELIB_URL = 'http://lib.haxe.org/files/'

  @@remote_cache = nil

  def initialize(haxe)
    @haxe = haxe
    if @@remote_cache.nil?
      @@remote_cache = remote_versions
    end
  end

  def require_lib(name)
    unless libraries.has_key? name
      install name
    end
  end

  def install(name)
    if can_install name
      puts "we can install #{name} (#{install_url name})"
    else
      puts "can't find #{name}"
    end
  end

  def can_install(name)
    @@remote_cache.has_key? name
  end

  def install_url(name)
    "#{HAXELIB_URL}#{name}-#{@@remote_cache[name]}.zip"
  end

    def zip_path
      File.join(@haxe.haxe_bin, 'zip')
    end

  def install_library(name)
    file = get_zip_target name
    download_zip name, file unless File.exists? file
    @haxe.lib("test #{file}")
  end

    def get_zip_target(name)
      directory = zip_path
      FileUtils.mkdir_p directory unless File.exists? directory
      File.join(directory, "#{name}.zip")
    end

    def download_zip(name, file)
      File.open(file, "wb") do |write_file|
        open(install_url name) do |read_file|
          write_file.write(read_file.read)
        end
      end
    end

  def libraries
    list = @haxe.lib('list')
    Hash[list.scan(/(.+?)\: \[(.+?)\]/)]
  end

  def remote_versions
    open(HAXELIB_URL) do |io|
      Hash[io.read.scan(/\<a href="(.+?)\-([0-9,.]+)\.zip">.+\<\/a\>/)]
    end
  end

end