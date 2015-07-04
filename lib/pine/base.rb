require 'pine/inheritable'

module Pine
  class Base
    include Inheritable

    inheritable :middlewares, []

    def initialize
      self.class.middlewares.each { |m, args, blk| builder.use m, *args, &blk }
    end

    def call(env)
      builder.run Controller.asd(env)
      @app = builder.to_app
      @app.call env
    end


    def builder
      @builder ||= Rack::Builder.new
    end

    class << self
      def use middleware, *args, &block
        self.middlewares << [middleware, args, block]
      end

      def get *args
      end
    end
  end
end
