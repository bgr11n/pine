module Pine
  module Inheritable
    # Just like NYNY does
    # https://github.com/alisnic/nyny/blob/master/lib/nyny/primitives.rb
    def self.included base
      base.class_eval do
        puts 'base - ' + base.to_s
        def self.inheritable name, value
          @_inheritables ||= []
          @_inheritables << name
          self.class.send :attr_accessor, name
          self.send "#{name}=", value
        end

        def self.inherited subclass
          @_inheritables.each do |attr|
            subclass.inheritable attr, self.send(attr)
          end
        end
      end
    end
  end
end
