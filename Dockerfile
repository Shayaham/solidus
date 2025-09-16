FROM quay.io/evl.ms/ruby-node:3.1-16-bullseye

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
  postgresql-client git

# Create app user
RUN useradd -m -d /home/solidus_user solidus_user
USER solidus_user

# Set working directory
WORKDIR /home/solidus_user/app

# Mark repo as safe for Git
RUN git config --global --add safe.directory /home/solidus_user/app

# Copy app code
COPY --chown=solidus_user:solidus_user . .

# Install gems
RUN bundle install

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
