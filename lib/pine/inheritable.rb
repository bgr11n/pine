module Pine
  module Inheritable
    def self.included base
      base.class_eval do
        def self.inheritable name, value
          @_inheritables ||= []
          @_inheritables << name
          puts 'self.class - ' + self.class.to_s
          self.class.send :attr_accessor, name
          self.send "#{name}=", value
        end

        def self.inherited subclass
          puts 'subclass - ' + subclass.to_s
          @_inheritables.each do |attr|
            subclass.inheritable attr, self.send(attr)
          end
        end
      end
    end
  end
end
