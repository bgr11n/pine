require 'pine/inheritance'

module Pine
  class Base
    extend Inheritance
    inheritable :widdlewares, []

    def call(env)
      Controller.asd(env)
    end

    def self.get *args
    end
  end
end
