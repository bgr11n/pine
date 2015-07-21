require 'pine/utils'
require 'pine/base'
require 'pine/app/router/router'
require 'pine/app/router/namespace'

module Pine
  class App < Base

    def call(env)
      # TODO: Handle request for favicon.ico
      return [ 404, {}, [] ] if env["PATH_INFO"] == "/favicon.ico"
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

      def namespace namespace, &blk
        Namespace.new self, namespace, &blk
      end
    end
  end
end
