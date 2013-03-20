#!/usr/bin/env ruby

class HaxeLibraryItem
  attr_reader :name, :versions

  def initialize(name, versions = [])
    @name = name
    @versions = versions
  end

  def info
    `haxelib info #{@name}`.chomp
  end

  def available?
    info != "No such Project : #{@name}"
  end

  def installed?
    `haxelib list`.include? @name
  end

  def install(version = '')
    command = "haxelib install #{@name} #{version}"
    `#{command}` unless installed?
  end

  def remove
    command = "haxelib remove #{@name}"
    `#{command}`
  end

  def most_recent_version
    @versions.sort.last
  end

  def current_version
    `haxelib list`.scan(/#{@name}.*\[(.+)\]/).first.first if installed?
  end

  def set_version(version)
   command = "haxelib set #{@name} #{version}"
    result = `#{command}`.chomp
    failure = "Library #{@name} version #{version} is not installed"
    if result == failure
      install = "haxelib install #{@name} #{version}"
      `#{install}`
      `#{command}`
    end
  end

end