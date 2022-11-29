# frozen_string_literal: true

# Example consumer that prints messages payloads
class ExampleConsumer < ApplicationConsumer
  def consume
    puts 'hai'
    messages.each { |message| puts message.payload }
  end

  # Run anything upon partition being revoked
  # def revoked
  # end

  # Define here any teardown things you want when Karafka server stops
  # def shutdown
  # end
end
