require "pine/version"
require "pine/base"
require "pine/controller"

module Pine
  class App < Base
    use BetterErrors::Middleware
  end

  class EnvString < String
    [:production, :development, :test].each do |env|
      define_method "#{env}?" do
        self == env.to_s
      end
    end
  end

  def self.env
    @env ||= EnvString.new(ENV['RACK_ENV'] || 'development')
  end
end
