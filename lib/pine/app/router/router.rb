module Pine
  class Router
    attr_accessor :routes

    def routes
      @routes ||= Hash.new { |hash, key| hash[key] = [] }
    end

    def endpoint(env)
      [404, { 'Content-type' => 'application/json' }, [env.inspect]]
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

  end
end
