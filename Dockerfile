FROM ruby:3.1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libyaml-dev build-essential git \
 && rm -rf /var/lib/apt/lists/*

# Create app user and set up home directory
RUN useradd -m -d /home/solidus_user solidus_user

# Switch to app user
USER solidus_user
WORKDIR /home/solidus_user/app
# Ensure correct ownership of the app directory
RUN chown -R solidus_user:solidus_user /home/solidus_user/app
# Set Git safe.directory config for this user
RUN git config --global --add safe.directory /home/solidus_user/app

# Copy app code
COPY --chown=solidus_user:solidus_user . .

# Install Ruby gems
RUN bundle install

# Start the app
CMD ["bash", "-c", "bundle exec rails s -b 0.0.0.0"]

