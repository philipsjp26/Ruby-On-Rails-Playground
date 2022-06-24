# frozen_string_literal: true

ApiPagination::Configuration.class_eval do
  attr_accessor :include_in_json_body

  def initialize
    @total_header = "Total"
    @per_page_header = "Per-Page"
    @page_header = nil
    @include_total = true
    @base_url = nil
    @response_formats = true
  end

  ApiPagination.configure do |config|
    config.paginator = :kaminari
    config.include_total = true
    config.total_header = "X-Total"
    config.per_page_header = "X-Per-Page"
    config.page_header = "X-Page"
    config.include_in_json_body = true
  end
end
