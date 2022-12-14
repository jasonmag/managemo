FROM ruby:3.1.2
ENV BUNDLE_PATH /usr/local/bundle

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    git \
    libpq-dev \
    postgresql-client \
    nodejs \
    yarn \
    libvips42 \ 
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3 \
  RAILS_ROOT=/app

RUN gem update --system && gem install bundler

WORKDIR $RAILS_ROOT

COPY .env.example $RAILS_ROOT/.env

# Setting env up
ENV RAILS_ENV='development'
ENV RACK_ENV='development'

# Adding gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --jobs 20 --retry 5

COPY entrypoint.sh $RAILS_ROOT/

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 3000

CMD ["bundle","exec","rails","s","-b","0.0.0.0"]


