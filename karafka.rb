# frozen_string_literal: true

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = { 'bootstrap.servers': '192.168.100.155:9099' }
    config.client_id = 'payground'    
  end
  routes.draw do
    topic :events do
      consumer ExampleConsumer
    end
  end
end
