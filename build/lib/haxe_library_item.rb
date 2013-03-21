#!/usr/bin/env ruby

class HaxeLibraryItem
  attr_reader :name, :versions

  def initialize(name, versions = [])
    @name = name
    @versions = versions
  end

  def is_blocked_by_proxy
    info.include? 'Failed to connect on localhost'
  end

  def info
    `haxelib info #{@name}`.chomp
  end

  def installed?
    `haxelib list`.include? @name
  end

  def install(version = nil)
    if (is_blocked_by_proxy)
      workaround = HaxeFirewallWorkaround.new(self, version)
      workaround.install if workaround.can_install?
    else
      install_using_haxelib(version)
    end
  end

  def install_using_haxelib(version = nil)
    command = "haxelib install #{@name} #{version.nil? ? '' : version}"
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
      install version
      `#{command}`
    end
  end

end