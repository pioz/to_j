require 'to_j/railtie'

module ToJ
  extend ActiveSupport::Concern

  included do
    klass_name = self.name
    proxy = Class.new do
      include "#{klass_name}Serializer".constantize rescue nil
      def initialize
        @json = Jbuilder.new
        yield(self) if block_given?
      end

      # rubocop: disable Style/MethodMissingSuper
      # rubocop: disable Style/MissingRespondToMissing
      def method_missing(method_name, *args, &block)
        @json.__send__(method_name, *args, &block)
      end
      # rubocop: enable all
    end
    Object.const_set("#{klass_name}JbuilderProxy", proxy)

    def self.to_j(options = {})
      Jbuilder.new do |json|
        json.array!(current_scope.map { |obj| obj.to_j(options) }) # test
      end.attributes!
    end

    def to_j(options = {})
      view = options[:view] || :default
      json = "#{self.class.name}JbuilderProxy".constantize.new
      if json.respond_to?(view)
        json.send(view, self, options.except(:view))
      elsif view != :default
        raise "Serializer view :#{view} does not exist!"
      else
        json.call(self, *self.class.column_names)
      end
      return json.attributes!
    end
  end
end
