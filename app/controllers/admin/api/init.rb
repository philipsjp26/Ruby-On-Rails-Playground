class Admin::Api::Init < Grape::API
  insert_after Grape::Middleware::Formatter, Grape::Middleware::Logger,
               logger: Logger.new(STDERR),
               filter: Class.new {
                 def filter(opts)
                   opts.reject { |k, _| k.to_s == "password" }
                 end
               }.new,
               headers: %w[version cache-control]

  # Build params using object
  include Grape::Extensions::Hashie::Mash::ParamBuilder

  mount Admin::Api::V1::Main
end
