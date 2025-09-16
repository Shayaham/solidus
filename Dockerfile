# Example: starting from a Ruby base image
FROM ruby:3.1

# Install dependencies for Solidus (including libyaml-dev for your psych error)
RUN apt-get update && apt-get install -y \
    libyaml-dev build-essential git \
 && rm -rf /var/lib/apt/lists/*

# Mark the repo path as safe for Git
RUN git config --system --add safe.directory /home/solidus_user/app

# Set working directory
WORKDIR /home/solidus_user/app

# Copy your app code
COPY . .

# Continue with your bundle install, etc.
RUN bundle install

CMD ["bash", "-c", "bundle exec rails s -b 0.0.0.0"]

