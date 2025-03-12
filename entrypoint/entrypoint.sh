#!/bin/sh

set -e


bundle exec rake db:migrate

if [[ $? != 0 ]]; then
  echo
  echo "== Failed to migrate. Running setup first."
  echo
  bundle exec rake db:create && \
  bundle exec rake db:migrate
fi
rm -rf tmp/pids/server.pid
bundle exec rails db:seed
bundle exec rails s -e development -p 3000
