require 'better_errors'

module Pine
  class App < Base
    use BetterErrors::Middleware
  end
end
