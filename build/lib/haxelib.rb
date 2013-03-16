#!/usr/bin/env ruby

require 'open-uri'
require 'net/http'
require 'fileutils'

class Haxelib

  HAXELIB_URL = 'http://lib.haxe.org/files/'

  @@remote_cache = nil

  def initialize
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

  def get_zip(name)
    file = get_zip_target name
    unless File.exists? file
      download_zip name, file
    end
    file
  end

  def get_zip_target(name)
    parent = File.expand_path(File.dirname(File.dirname(__FILE__)))
    directory = File.join(parent, "zip")
    unless File.directory? directory
      FileUtils.mkdir_p directory
    end
    File.join(directory, "#{name}.zip")
  end

  def download_zip(name, file)
    File.open(file, "wb") do |write_file|
      open(install_url name) do |read_file|
        write_file.write(read_file.read)
      end
    end
  end

  def install_library(name)
    `haxelib test #{get_zip name}`
  end

  def libraries
    Hash[`haxelib list`.scan(/(.+?)\: \[(.+?)\]/)]
  end

  def remote_versions
    open(HAXELIB_URL) do |io|
      Hash[io.read.scan(/\<a href="(.+?)\-([0-9,.]+)\.zip">.+\<\/a\>/)]
    end
  end

end