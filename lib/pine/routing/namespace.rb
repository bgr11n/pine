require 'delegate'
require 'pine/routing/route'

module Pine
  HTTP_VERBS = [:delete, :get, :head, :options, :patch, :post, :put, :trace]

  class Namespace < SimpleDelegator
    def initialize app, namespace, &blk
      @app = app
      @name = '/' + namespace
      __setobj__(@app)
      instance_eval(&blk)
    end

    HTTP_VERBS.each do |verb|
      define_method verb do |path, options={}, &block|
        super(@name + path, options, &block)
      end
    end

    def namespace namespace, &blk
      Namespace.new self, namespace, &blk
    end
  end
end
