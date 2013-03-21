#!/usr/bin/env ruby

require 'yaml'

class HaxeConfig
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def haxe
    @data['haxe']
  end

  def get(category, key)
    data = get_category category, key
    data.nil? || data[key] == 'nil' ? nil : data[key]
  end

    def get_category(category, key)
      if @data[category].nil? || @data[category][key].nil?
        @data['default']
      else
        @data[category]
      end
    end

  def libs(*args)
    list = Array.new
    args.each do |arg|
      data = get(arg, 'libs')
      list << data.split(' ') unless data.nil?
    end
    list.flatten.uniq
  end

  def get_binding
    binding
  end

end
