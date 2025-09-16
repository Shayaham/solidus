FROM ruby:3.1-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    libyaml-dev \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .
RUN bundle install --jobs=4 --retry=3
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
