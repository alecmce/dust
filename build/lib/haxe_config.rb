#!/usr/bin/env ruby

require 'yaml'

class HaxeConfig
  attr_reader :data, :contexts, :testing

  def initialize(path)
    @path = path
    @data = YAML.load_file path
    define_contexts
    define_testing
    default
  end

  def define_contexts
    @contexts = Array.new
    @data.each_key do |context|
      @contexts << context unless context == 'testing'
    end
  end

  def define_testing
    @testing = MunitConfig.new(@data['testing'])
  end

  def default
    apply_context 'default'
  end

  def set_context(name)
    default unless name == 'default'
    apply_context name if @data.has_key? name
  end

    def apply_context context
      define_value('get_context', context)
      @data[context].each do |key, value|
        define_value key, value
      end
    end

      def define_value(key, value)
        self.class.send(:define_method, key) do
          value
        end
      end

  def has?(context)
    @contexts.include? context
  end

  def get_binding
    binding
  end

end

