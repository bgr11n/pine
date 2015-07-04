module Pine
  class Controller
    attr_reader :request

    def initialize(env)
      @request = Rack::Request.new env
    end

    def params
      request.params
    end

    def self.asd(env)
      -> (env) { [ 200, { 'Content-type' => 'text/html' }, [HomeController.new(env).index] ] }
    end
  end
end
