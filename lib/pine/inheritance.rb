module Pine
  module Inheritance
    def inheritable name, value
      self.class.send(:attr_accessor, name)
      self.send("#{name}=", value)
      puts '---'
      puts self.middlewares.inspect
      puts '---'
    end
  end
end
