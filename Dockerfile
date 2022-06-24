FROM ruby:3.1.0

ENV BUNDLER_VERSION=2.3.3
ENV RAILS_ENV=development

RUN apt-get install -y libpq-dev

RUN gem install bundler -v 2.3.3

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle check || bundle install 


COPY . /app

RUN chmod +x /app/entrypoint/entrypoint.sh
ENTRYPOINT ["/app/entrypoint/entrypoint.sh"]
EXPOSE 3000 