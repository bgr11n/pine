require 'pine/response'

module Pine
  class Route
    attr_accessor :routes, :response

    def endpoint
      -> (env) { take_a_journey env }
    end

    def take_a_journey env
      # TODO: when no routes matches (nil) render json 404
      route = routes[request_method(env)].detect { |route| path_info(env) =~ route[:path] }
      controller, action = route[:options][:to].split('#')
      Object.const_get("#{controller.to_camel_case}Controller").new(env).get_response(action)
    end

    def write verb, path, options
      routes[verb] << { path: compile(path), options: options }
    end

    def compile path
      compiled_path = path.gsub(/:\w+/) do |match|
        # TODO: add to request.params :id parameters from routes
        '([^/?#]+)'
      end
      /^#{compiled_path}$/
    end

    def routes
      @routes ||= Hash.new { |hash, key| hash[key] = [] }
    end

    def response
      @response ||= Response.new(self)
    end

    def request_method env
      env['REQUEST_METHOD'].downcase.to_sym
    end

    def path_info env
      env['PATH_INFO'].downcase
    end
  end
end
