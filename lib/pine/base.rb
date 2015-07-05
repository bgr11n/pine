require 'pine/inheritable'
require 'pine/routing/namespace'

module Pine
  class Base
    include Inheritable

    inheritable :middlewares, []
    inheritable :routes, []

    def initialize
      puts self.class.routes.inspect
      self.class.middlewares.each { |m, args, blk| builder.use m, *args, &blk }
      builder.run Controller.asd
      @app = builder.to_app
    end

    def call(env)
      @app.call env
    end

    def builder
      @builder ||= Rack::Builder.new
    end

    class << self
      def use middleware, *args, &block
        self.middlewares << [middleware, args, block]
      end

      HTTP_VERBS.each do |verb|
        define_method verb do |path, options={}, &block|
          self.routes << [path, options, block]
        end
      end

      def namespace namespace, &blk
        Namespace.new self, namespace, &blk
      end
    end
  end
end
