FROM docker.io/ruby:2.5.1

RUN gem install bundler

WORKDIR /usr/local/src

COPY Gemfile .

RUN bundle install
