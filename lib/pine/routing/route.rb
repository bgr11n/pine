require 'pine/controller/base'

module Pine
  class Route
    attr_accessor :routes

    def endpoint
      -> (env) { take_a_journey env }
    end

    def take_a_journey env
      route = routes[request_method(env)].detect { |route| path_info(env) =~ route[:path] }
      Controller::Base.run_by(route, env)
    end

    def write verb, path, options
      routes[verb] << compile(verb, path, options)
    end

    def compile verb, path, options
      params = {}
      compiled_path = path.gsub(/:\w+/) do |match|
        params[match[1..-1].to_sym] = nil
        '([^/?#]+)'
      end
      { path: /^#{compiled_path}$/, options: options, params: params }
    end

    def routes
      @routes ||= Hash.new { |hash, key| hash[key] = [] }
    end

    def request_method env
      env['REQUEST_METHOD'].downcase.to_sym
    end

    def path_info env
      env['PATH_INFO'].downcase
    end
  end
end
