class LatestStockPrice::Stock
  class << self
    def get_price_all
      url = "https://latest-stock-price.p.rapidapi.com/any"
      headers = {
        "x-rapidapi-host": "latest-stock-price.p.rapidapi.com",
        "x-rapidapi-key": "2330b4273cmsh4b779de58fc01e4p16924fjsn2907f493cb21"
      }
      data = ApiRequest.http_get(url, nil, headers)
      data
    end

    def get_prices(code)
      url = "https://latest-stock-price.p.rapidapi.com/equities-enhanced"
      headers = {
        "x-rapidapi-host": "latest-stock-price.p.rapidapi.com",
        "x-rapidapi-key": "2330b4273cmsh4b779de58fc01e4p16924fjsn2907f493cb21"
      }
      params = {
        Symbols: code.to_s
      }
      data = ApiRequest.http_get(url, params, headers)
      data
    end

  end
end