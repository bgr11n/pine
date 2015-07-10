module Pine
  class Controller
    attr_reader :request, :response, :status, :headers

    def initialize(env)
      @request = Rack::Request.new env
      @response = Response.new
    end

    def get_response action
      response.body = [self.send(action)]
      [ response.status, response.headers, response.body ]
    end

    def params
      request.params
    end

    def status val
      response.status = val
    end

    def headers

    end
  end
end
