require 'pine/Inheritable'

module Pine
  class Base
    include Inheritable

    inheritable :middlewares, []

    def initialize
      puts self.class.middlewares.inspect
    end

    def call(env)
      Controller.asd(env)
    end

    def self.use middleware, *args, &block
      middlewares << [middleware, args, block]
    end

    def self.get *args
    end
  end
end
