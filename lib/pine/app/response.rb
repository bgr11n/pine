module Pine
  class Response
    attr_accessor :status, :headers, :body

    def build
      headers['Content-Length'] = '' unless body.is_a? String
      [status, headers, [body]]
    end

    def status
      @status ||= 200
    end

    def headers
      @headers ||= { 'Content-Type' => 'text/html' }
    end

    def self.not_found
      [404, {}, ['Not Found']]
    end
  end
end
