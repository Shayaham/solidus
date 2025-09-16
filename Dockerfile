


FROM ruby:3.1-slim
RUN git config --system --add safe.directory /home/solidus_user/app
# Install system deps for psych (YAML) and other C-extensions
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    libyaml-dev \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

# Install gems
RUN bundle config set without 'development test' \
  && bundle install --jobs=4 --retry=3

# Expose and launch
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

