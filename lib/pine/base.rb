require 'better_errors'

module Pine
  class Base
    attr_accessor :builder

    def initialize
    end

    def call(env)
      Controller.asd(env)
    end

    def self.use middleware, *args, &block
      builder ||= Rack::Builder.new
      builder.use middleware, *args, &block
    end

    def self.get *args
    end
  end
end
