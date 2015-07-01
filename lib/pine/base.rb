require 'pine/inheritance'

module Pine
  class Base
    extend Inheritance
    inheritable :middlewares, []

    def call(env)
      Controller.asd(env)
    end

    def self.use middleware, *args, &block
      puts 'in self.use method'
    end

    def self.get *args
    end
  end
end
