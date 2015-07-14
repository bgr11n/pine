require 'pine/utils'
require 'pine/environment'
require 'pine/controller'
require 'pine/base'
require 'better_errors'

module Pine
  class App < Base
    # TODO: only for development
    use BetterErrors::Middleware
  end
end
