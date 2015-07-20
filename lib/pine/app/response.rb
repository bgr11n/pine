module Pine
  class Response
    attr_accessor :status, :headers, :body

    def build
      [status, headers, [body]]
    end

    def status
      @status ||= 200
    end

    def headers
      @headers ||= { 'Content-Type' => 'text/html' }
    end
  end
end
