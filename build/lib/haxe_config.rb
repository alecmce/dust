#!/usr/bin/env ruby

class HaxeConfig
  attr_reader :data, :contexts

  def initialize(path)
    @path = path
    @data = YAML.load_file path
    @contexts = Array.new
    define_contexts
    default
  end

  def define_contexts
    @data.each_key do |context|
      @contexts << context unless context.to_s == 'testing'
    end
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

