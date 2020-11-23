module KLog
  class HTTPFormatter
    def format_request(request, url)
      message = format_message(request) do
        message =  "{ HEADER{#{get_header(request)}"
        message << " METHOD[#{request.method.upcase}]"
        message << " URL[#{url}]"
        message << " } REQUEST_BODY -> "
      end
    end

    def format_response(response)
      message = format_message(response) do
        message =  "{ VERSION[HTTP/#{response.http_version}]"
        message << " CHARSET[#{charset(response)}]"
        message << " CONTENT_TYPE[#{response.content_type}]"
        message << " CODE[#{response.code}]"
        message << " MESSAGE[#{response.message}]"
        message << " } RESPONSE_BODY -> "
      end
    end

    private
    def get_header(request)
      message = ""
      request.each_header do |k,v|
        message << " #{k.upcase}[#{v}]"
      end
      message
    end

    def format_message(http)
      message = yield
      body = extract_body_from(http)
      unless blank?(body)
        message << with_line_break { body }
      end
      message
    end

    def with_line_break
      "#{yield}\n"
    end

    def extract_body_from(http)
      return http.body if http.respond_to?(:body)
      return http.args[:payload] if http.respond_to?(:args)
      return nil
    end

    def blank?(text)
      text.to_s.strip.empty?
    end

    def charset(response)
      response['content-type'].split("=").last if response['content-type']
    end
  end
end
