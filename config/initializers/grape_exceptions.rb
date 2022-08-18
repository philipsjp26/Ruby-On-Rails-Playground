# frozen_string_literal: true

require "grape/exceptions/base"
Grape::Exceptions::ValidationErrors.class_eval do
  def as_json_custom(**_opts)
    errors.map do |k, v|
      {
        param: k.try(:[], 0),
        messages: v.map(&:to_s)
      }
    end
  end
end
