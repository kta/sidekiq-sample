ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION

ENV LANG C.UTF-8
WORKDIR /app

RUN apt-get update \
	&& apt-get install -y build-essential \
	libpq-dev \
	postgresql-client

ARG BUNDLER_VERSION
RUN gem install bundler -v $BUNDLER_VERSION


RUN bundle config path /usr/local/bundle
COPY \
	Gemfile \
	Gemfile.lock \
	/app/
RUN bundle install --jobs=4

COPY . /app
