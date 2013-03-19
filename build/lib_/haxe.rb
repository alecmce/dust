#!/usr/bin/env ruby

require 'fileutils'

class Haxe
  attr_reader :config

  VERSION_2_10 = 'http://haxe.org/file/haxe-2.10-osx.tar.gz'
  VERSION_3_RC = 'http://haxe.org/file/haxe-3.0.0-rc-osx.tar.gz'
  HAXE_BIN = '~/bin/haxe'

  def initialize(config)
    @config = config
    setup
  end

  def setup
    FileUtils.mkdir_p haxe_bin unless File.exists? haxe_bin
    configure unless configured?
    set_haxe_version
  end

  def version
    config.haxe_version
  end

    def set_haxe_version
      remote = get_link
      zipped = File.join(haxe_bin, File.basename(remote))
      @haxe = zipped.sub('.tar.gz', '')
      `#{download_command(remote, zipped)}` unless File.exists? zipped
      `#{unzip_command(zipped)}` unless File.exists? @haxe
      set_to_actual
    end

    def haxe_bin
      File.expand_path HAXE_BIN
    end

    def haxe_actual
      File.expand_path HAXE_ACTUAL
    end

    def standard_library
      File.join haxe_actual, 'std:.'
    end

    def haxepath
      File.expand_path(File.join `which haxe`.chomp, '..')
    end

    def report_required_export(name, value)
      "export #{name}=\"#{value}\""
    end

    def get_link
      version == 3 ? VERSION_3_RC : VERSION_2_10
    end

    def download_command(remote, local)
      "curl #{remote} > #{local}"
    end

    def unzip_command(local)
      dir = File.dirname(local)
      "cd #{dir} && gunzip -c #{local} | tar xopf -"
    end

    def set_to_actual
      FileUtils.rm_rf haxe_actual
      `ln -s #{@haxe} #{haxe_actual}`
    end

  def run(argument)
    command = "haxe -cp #{standard_library} #{argument}"
    `#{command}`
  end

  def lib(argument)
    command = "haxelib #{argument}"
    puts command
    `#{command}`
  end

end