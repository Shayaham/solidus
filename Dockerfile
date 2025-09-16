FROM ruby:3.1.2

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs postgresql-client libyaml-dev build-essential git

# Create and switch to app user
RUN useradd -m -d /home/solidus_user solidus_user
USER solidus_user

# Set working directory
WORKDIR /home/solidus_user/app

# Mark repo as safe for Git
RUN git config --global --add safe.directory /home/solidus_user/app

# Copy app code and fix ownership
COPY --chown=solidus_user:solidus_user . .

# Install Ruby gems
RUN bundle config build.psych --with-libyaml-dir=/usr && bundle install

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
