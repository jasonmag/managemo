#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails
rm -f /app/tmp/pids/server.pid

echo "bundle install..."
bundle check || bundle install --jobs 4
bundle exec rake tmp:cache:clear

# Then exec the container's main process (what's set as CMD in the Dockerfile)
exec "$@"

# yarn build --watch

# yarn build:css --watch

# bin/rails tailwindcss:watch