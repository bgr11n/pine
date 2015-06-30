module Pine
  class Controller
    attr_reader :request

    def initialize(env)
      @request = Rack::Request.new env
    end

    def self.asd(env)
      [ 200, { 'Content-type' => 'text/html' }, [HomeController.new(env).index] ]
    end
  end
end
