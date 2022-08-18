# frozen_string_literal: true

class OauthService
  class << self
    def credential(access_token)
      headers = { :Authorization => "Bearer #{access_token}" }
      params = "?client_id=#{Configuration.get("auth_client_id")}&client_secret=#{Configuration.get("auth_client_secret")}"      
      ApiRequest.http_get("#{Configuration.get("dci_auth_service")}/api/v1/credential#{params}", headers)      

    end

    def proxy(access_token, auth_client_id, auth_client_secret)
      headers = { :Authorization => "#{access_token}" }
      params = "?client_id=#{auth_client_id}&client_secret=#{auth_client_secret}"
      response, status_code = ApiRequest.http_get(url: "#{Configuration.get("dci_auth_service")}/api/v1/credential#{params}", headers: headers)
      [response, status_code]
    end

    def logout(access_token, auth_client_id, auth_client_secret)
      headers = { :Authorization => "#{access_token}" }
      body = {
        client_id: auth_client_id,
        client_secret: auth_client_secret,
      }
      response, status_code = ApiRequest.http_post(
        application: 0,
        url: "#{Configuration.get("dci_auth_service")}/api/v1/credential/destroy",
        body: body,
        headers: headers,
      )
      [response, status_code]
    end

    def token(body = {})
      require "uri"
      require "net/http"
      url = URI("#{Configuration.get("dci_auth_service")}/oauth/token")
      http = Net::HTTP.new(url.host, url.port)
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/x-www-form-urlencoded"

      request.body = "client_id=#{body[:client_id]}&client_secret=#{body[:client_secret]}&grant_type=#{body[:grant_type]}&code=#{body[:code]}&redirect_uri=#{body[:redirect_uri]}"
      response = http.request(request)
      [response.read_body, response.code]
    end
  end
end
