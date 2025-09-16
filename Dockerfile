FROM ruby:3.1

# Install required system packages
RUN apt-get update && apt-get install -y \
    libyaml-dev build-essential git \
 && rm -rf /var/lib/apt/lists/*

# Create app user
RUN useradd -m -d /home/solidus_user solidus_user

USER solidus_user
WORKDIR /home/solidus_user/app

# Set Git safe directory
RUN git config --global --add safe.directory /home/solidus_user/app

# Copy app code
COPY --chown=solidus_user:solidus_user . .

# Install gems
RUN bundle install

CMD ["bash", "-c", "bundle exec rails s -b 0.0.0.0"]
