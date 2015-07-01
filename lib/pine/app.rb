require 'better_errors'

module Pine
  class App < Base
    use BetterErrors::Middleware unless Pine.env.production?
  end
end
