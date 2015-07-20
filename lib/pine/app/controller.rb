require 'pine/app/response'

module Pine
  class Controller
    attr_accessor :request, :response

    def initialize(env, route)
      @request = Rack::Request.new env
      @response = Response.new
      fetch_url(route) unless route[:extra_params].empty?
    end

    def self.follow_by route, env
      controller, action = route[:options][:to].split('#')
      Object.const_get("#{controller.to_camel_case}Controller").new(env, route).get_response(action)
    end

    def get_response action
      response.body = self.send(action)
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
