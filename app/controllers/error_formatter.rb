module ErrorFormatter
  def self.call(message, _backtrace, _options, env, _original_exception)
    {
      code: env["api.response.code"],
      messages: [message],
    }.to_json
  end
end
