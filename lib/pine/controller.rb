require 'pine/response'

module Pine
  class Controller
    attr_reader :request, :response, :status, :headers

    def initialize(env, route)
      @request = Rack::Request.new env
      fetch_url_params(route) unless route[:params].empty?
      @response = Response.new
    end

    def self.run_by route, env
      controller, action = route[:options][:to].split('#')
      Object.const_get("#{controller.to_camel_case}Controller").new(env, route).form_response(action)
    end

    def form_response action
      response.body = [self.send(action)]
      [ response.status || 200, response.headers || {}, response.body ]
    end

    def fetch_url_params route
      route[:params].each { |k, v| params[k] = route[:path].match(request.path_info)[1] }
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
