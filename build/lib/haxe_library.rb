#!/usr/bin/env ruby

require 'open-uri'
require 'net/http'
require 'fileutils'

class HaxeLibrary

  HAXELIB_URL = 'http://lib.haxe.org/files/'

  @@items = nil

  def initialize
    @@items = make_items if @@items.nil?
  end

  def library(name)
    @@items[name]
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
      hash = Hash.new
      library_list.each do |key, value|
        value = value.gsub(',','.')
        hash.has_key?(key) ? hash[key] << value : hash[key] = [value]
      end
      hash
    end

      def library_list
        open(HAXELIB_URL) do |io|
          Array[io.read.scan(/\<a href="(.+?)\-([0-9,.]+)\.zip">.+\<\/a\>/)].first
        end
      end

end