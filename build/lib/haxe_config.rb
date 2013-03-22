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
    get_value_from_category data, key
  end

  def get_flag(category, key)
    data = get(category, key)
    not (data.nil? or data =~ false)
  end

    def get_category(category, key)
      if @data[category].nil? || @data[category][key].nil?
        @data['default']
      else
        @data[category]
      end
    end

    def get_value_from_category(data, key)
      data.nil? || data[key] == 'nil' ? nil : data[key]
    end

  def get_list(categories, key)
    list = Array.new
    ([categories] << 'default').flatten.each do |category|
      data = get(category, key)
      list << data.split(' ') unless data.nil?
    end
    list.flatten.uniq
  end

  def get_binding
    binding
  end

end
