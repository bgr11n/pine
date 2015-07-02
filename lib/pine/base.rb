require 'pine/inheritable'

module Pine
  class Base

    def call(env)
      Controller.asd(env)
    end

    def initialize
      puts '-- from init --'
      puts self.class.asd.inspect
      puts '-- /from init --'
    end

    class << self

      def asd
        @asd ||= []
      end

      def use middleware, *args, &block
        asd << [middleware, args, block]
      end

      def inherited base
        puts 'self.asd - ' + self.to_s + ' = ' + self.asd.inspect
        puts 'base.asd - ' + base.to_s + ' = ' + base.asd.inspect
        puts '!! ' + self.to_s + ' was inherited by ' + base.to_s
        puts '------- end --------'
      end

      def get *args
      end
    end
  end
end
