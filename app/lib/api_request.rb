class ApiRequest
  class << self
    def http_get(url, headers = {})
      RestClient.get(url, headers)
    rescue Exception => e
      e.response
    end

    def http_post(url, body, headers = {})
      RestClient.post(url, body, headers)
    rescue Exception => e
      e.response
    end

    def http_put(url, body, headers = {})
    rescue Exception => e
      e.response
    end

    def http_delete(url, headers = {})
    rescue Exception => e
      e.response
    end
  end
end

# private_class_method :new
# attr_reader :conn

# def self.http_get(url, headers = {})
#   new.conn.get(url, headers)
# rescue Faraday::Response::RaiseError => e
#   e.response
# end

# def self.http_post(url, body, headers = {})
#   new.conn.post(url, body, headers)
# rescue Faraday::Response::RaiseError => e
#   e.response
# end

# def self.http_put(url, body, headers = {})
#   new.conn.put(url, body, headers)
# rescue Faraday::Response::RaiseError => e
#   e.response
# end

# def self.http_delete(url, headers = {})
#   new.conn.delete(url, headers)
# rescue Faraday::Response::RaiseError => e
#   e.response
# end

# def initialize
#   @conn = Faraday.new do |config|
#     config.request :json
#     config.response :json
#     config.adapter Faraday.default_adapter
#   end
# end
