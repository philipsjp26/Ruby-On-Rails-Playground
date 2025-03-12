class Api::Init < Grape::API
  insert_after Grape::Middleware::Formatter, Grape::Middleware::Logger,
               logger: Logger.new($stderr),
               filter: Class.new {
                 def filter(opts)
                   opts.reject do |k, _|
                     k.to_s == "password"
                   end
                 end
               }.new,
               headers: %w[version cache-control]

  include Grape::Extensions::Hashie::Mash::ParamBuilder
  include ExceptionHandler

  mount Api::V1::Main
end
