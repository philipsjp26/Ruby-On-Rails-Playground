module SuccessFormatter
  def self.call(object, env)
    response = {
      message: env["api.response.message"].present? ? env["api.response.message"] : "Success retrieve data",
      data: object.try(:[], :meta).present? ? object.except(:meta) : object,
    }
    response[:meta] = object[:meta] if object.try(:[], :meta).present?
    response.to_json
  end
end
