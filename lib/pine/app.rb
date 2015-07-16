require 'pine/utils'
require 'pine/base'
require 'pine/app/router/router'
require 'pine/app/router/namespace'

module Pine
  HTTP_VERBS = [:delete, :get, :head, :options, :patch, :post, :put, :trace]

  class App < Base

    def call(env)
      self.class.router.endpoint(env)
    end

    class << self
      attr_accessor :router

      def router
        @router ||= Router.new
      end

      HTTP_VERBS.each do |verb|
        define_method verb do |path, options|
          router.add verb, path, options
        end
      end
    end
  end
end
