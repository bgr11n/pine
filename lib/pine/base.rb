require 'pine/inheritable'

module Pine
  class Base
    include Inheritable

    inheritable :middlewares, []

    def call(env)
      Controller.asd(env)
    end

    def initialize
      puts '!! ' + self.class.middlewares.inspect
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
