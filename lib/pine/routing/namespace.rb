require 'pine/routing/route'

module Pine
  class Namespace
    def initialize app, namespace, &blk
      @app = app
      @name = '/' + namespace
      self.instance_eval(&blk)
    end

    [:delete, :get, :head, :options, :patch, :post, :put, :trace].each do |verb|
      define_method verb do |path, options={}, &block|
        @app.send(verb, @name + path, options, &block)
      end
    end

    def namespace namespace, &blk
      Pine::Namespace.new self, namespace, &blk
    end
  end
end
