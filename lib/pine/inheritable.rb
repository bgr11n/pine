module Pine
  module Inheritable
    # def asd
    #   @asd ||= []
    # end

    # def inherited base
    #   puts 'self.asd - ' + self.to_s + ' = ' + self.asd.inspect
    #   puts 'base.asd - ' + base.to_s + ' = ' + base.asd.inspect
    #   puts '!! ' + self.to_s + ' was inherited by ' + base.to_s
    #   puts '------- end --------'
    #   self.asd.each { |m| base.asd << m }
    # end
    def self.included base
      base.class_eval do
        def self.inheritable name, value
          @_inheritables ||= []
          @_inheritables << name
          self.class.send :attr_accessor, name
          self.send "#{name}=", value
        end

        def self.inherited subclass
          @_inheritables.each do |attr|
            subclass.inheritable attr, self.send(attr).dup
          end
        end
      end
    end
  end
end
