#!/usr/bin/env ruby

class MunitConfig
  attr_accessor :version, :test, :bin, :report, :src,
                :browser, :resources, :templates, :coverage, :ignored

  def initialize(data)
    @data = data
    @version = data['version']
    @test = data['test']
    @bin = data['bin']
    @report = data['report']
    @src = data['src']

    @browser = get_optional 'browser'
    @resources = get_optional 'resources'
    @templates = get_optional 'templates'
    @coverage = get_optional 'coverage'
    @ignored = get_optional 'ignored'
  end

  def get_optional(key)
    is_defined?(key) ? @data[key] : nil
  end

  def is_defined?(key)
    @data.has_key?(key) && @data[key] != 'nil'
  end

  def get_binding
    binding
  end

end