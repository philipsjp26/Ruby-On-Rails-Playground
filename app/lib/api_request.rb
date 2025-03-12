class ApiRequest
  private_class_method :new
  attr_reader :conn

  def self.http_get(url, params = {}, headers = {})
    new.conn.get(url, params) do |req|
      req.headers.merge!(headers)
    end
  rescue Faraday::Response::RaiseError => e
    e.response
  end

  def self.http_post(url, body, headers = {})
    new.conn.post(url, body, headers)
  rescue Faraday::Response::RaiseError => e
    e.response
  end

  def self.http_put(url, body, headers = {})
    new.conn.put(url, body, headers)
  rescue Faraday::Response::RaiseError => e
    e.response
  end

  def self.http_delete(url, headers = {})
    new.conn.delete(url, headers)
  rescue Faraday::Response::RaiseError => e
    e.response
  end

  def initialize
    @conn = Faraday.new do |config|
      config.response :json
    end
  end
end
