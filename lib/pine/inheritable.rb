require 'active_support/core_ext/object/deep_dup'

module Pine
  module Inheritable
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
            subclass.inheritable attr, self.send(attr).deep_dup
          end
        end
      end
    end
  end
end
