#!/usr/bin/env ruby

class HaxeLibraryItem
  attr_reader :name, :versions

  def initialize(name, versions = [])
    @name = name
    @versions = versions
  end

  def info
    `haxelib info #{@name}`
  end

  def available?
    info != "No such Project : #{@name}"
  end

  def installed?
    `haxelib list`.include? @name
  end

  def install(version = '')
    `haxelib install #{@name} #{version}` unless installed?
  end

  def remove
    `haxelib remove #{@name}`
  end

  def current_version
    `haxelib list`.scan(/#{@name}.*\[(.+)\]/).first.first if installed?
  end

  def set_version(version)
    command = "haxelib set #{@name} #{version}"
    if `#{command}` == "Library #{@name} version #{version} is not installed"
      install version
      `#{command}`
    end
  end

end