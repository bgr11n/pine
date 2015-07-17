require 'pine/app/controller'

module Pine
  class Router
    attr_accessor :routes

    def routes
      @routes ||= Hash.new { |hash, key| hash[key] = [] }
    end

    def endpoint(env)
      route = routes[request_method(env)].detect { |route| path_info(env) =~ route[:path] }
      Controller.follow_by(route, env)
    end

    def add verb, path, options
      routes[verb] << compile_route(path, options)
    end

    def compile_route path, options
      extra_params = {}
      compiled_path = path.gsub(/:\w+/) do |match|
        extra_params[match[1..-1].to_sym] = nil
        '([^/?#]+)'
      end
      { path: /^#{compiled_path}$/, options: options, extra_params: extra_params }
    end

    def request_method env
      env['REQUEST_METHOD'].downcase.to_sym
    end

    def path_info env
      env['PATH_INFO'].downcase
    end
  end
end
