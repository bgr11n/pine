module Pine
  class Base

    def initialize
      puts "!! " + self.class.router.routes.inspect
    end

    def call(env)
      [404, { 'Content-type' => 'application/json' }, [env.inspect]]
    end

  end

  # Pine environment utility. Makes avaliable such methods like:
  # - Pine.env.development?
  # - Pine.env.production?
  # - Pine.env.test?
  class EnvString < String
    [:production, :development, :test].each do |env|
      define_method "#{env}?" do
        self == env.to_s
      end
    end
  end

  # Pine.env variable to store application environment
  def self.env
    @env ||= EnvString.new(ENV['RACK_ENV'] || 'development')
  end
end
