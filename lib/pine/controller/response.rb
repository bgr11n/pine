module Pine
  module Controller
    class Response
      attr_accessor :status, :headers, :body

      def self.not_found
        [404, { 'Content-type' => 'application/json' }, ['not found']]
      end
    end
  end
end
