module Pine
  class Route
    attr_accessor :routes

    def add path, options={}, &block
      @routes ||= []
      @routes << [path, options, block]
    end

    [:delete, :get, :head, :options, :patch, :post, :put, :trace].each do |verb|
      define_method verb do |path, options={}, &block|
        add(path, options, &block)
      end
    end
  end
end
