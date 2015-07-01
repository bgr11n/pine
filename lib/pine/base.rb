module Pine
  class Base
    class << self
      def use middleware, *args, &block
      end
    end

    def call(env)
      Controller.asd(env)
    end

    def self.get *args
    end
  end
end
