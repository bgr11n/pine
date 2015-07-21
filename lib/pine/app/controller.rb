module Pine
  class Controller
    attr_accessor :request, :response

    def initialize(env, route)
      @request = Rack::Request.new env
      @response = Response.new
      fetch_url(route) unless route[:extra_params].empty?
    end

    class << self
      attr_accessor :before_actions, :after_actions

      def before_action method
        before_actions << method
      end

      def after_action method
      end

      def before_actions
        @before_actions ||= []
      end

      def follow_by route, env
        return Response.not_found if route.nil?
        controller, action = route[:options][:to].split('#')
        Object.const_get("#{controller.to_camel_case}Controller").new(env, route).get_response(action)
      end
    end

    def get_response action
      self.class.before_actions.each { |method| self.send(method) }
      response.body = self.send(action) || ''
      response.build
    end

    def fetch_url route
      route[:extra_params].each { |k,v| params[k] = route[:path].match(request.path_info)[1] }
    end

    def params
      request.params
    end

    def status val
      response.status = val
    end

    def headers
      response.headers
    end
  end
end
