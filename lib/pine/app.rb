require "pine/environment"
require "pine/controller"
require "pine/base"
require "better_errors"

module Pine
  class App < Base
    use BetterErrors::Middleware unless Pine.env.development?
  end
end
