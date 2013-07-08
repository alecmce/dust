#!/usr/bin/env ruby

require 'open-uri'
require 'net/http'
require 'fileutils'
require 'yaml'

class HaxeLibrary

  HAXELIB_URL = 'http://lib.haxe.org/files/3.0/'
  HAXELIB_CACHE = '.haxelib_cache'

  @@items = nil

  def initialize
    @@items = make_items if @@items.nil?
  end

  def library(name)
    @@items[name] ||= HaxeLibraryItem.new(name)
  end

  def offline?
    @offline == true
  end

  def available?(name)
    item = library(name)
    not (item.current_version.nil? or item.versions.empty?)
  end

  private

  def make_items
    hash = Hash.new
    library_versions.map do |key, value|
      hash[key] = HaxeLibraryItem.new(key, value)
    end
    hash
  end

    def library_versions
      have_cached_library ? library_versions_from_cache : library_versions_from_live
    end

      def have_cached_library
        file = File.join(Dir.pwd, HAXELIB_CACHE)
        File.exists?(file) && was_cached_today(file)
      end

        def was_cached_today(file)
          Time.now - File.mtime(file) < 24 * 60 * 60
        end

      def library_versions_from_cache
        YAML::load_file File.join(Dir.pwd, HAXELIB_CACHE)
      end

      def library_versions_from_live
        hash = Hash.new
        library_list.each do |key, value|
          value = value.gsub(',','.')
          hash.has_key?(key) ? hash[key] << value : hash[key] = [value]
        end
        write_hash_to_cache hash
        hash
      end

        def write_hash_to_cache(hash)
          File.open(File.join(Dir.pwd, HAXELIB_CACHE), 'w') do |file|
            file.write hash.to_yaml
          end
        end

      def library_list
        begin
          open(HAXELIB_URL) do |io|
            Array[io.read.scan(/\<a href="(.+?)\-([0-9,.]+)\.zip">.+\<\/a\>/)].first
          end
        rescue Exception
          @offline = true
          []
        end
      end

end