require 'better_errors'

module Pine
  class App < Base
    use BetterErrors::Middleware
    use 'asd1'
  end
end
