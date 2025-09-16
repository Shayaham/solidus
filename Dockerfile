FROM ruby:3.1

# Install system packages
RUN apt-get update && apt-get install -y \
    libyaml-dev build-essential git pkg-config \
 && rm -rf /var/lib/apt/lists/*
RUN bundle config build.psych --with-yaml-dir=/usr --with-cflags="-I/usr/include"


# Create app user
RUN useradd -m -d /home/solidus_user solidus_user

USER solidus_user
WORKDIR /home/solidus_user/app

# Set Git safe directory
RUN git config --global --add safe.directory /home/solidus_user/app

# Explicitly tell Bundler where to find libyaml
RUN bundle config build.psych --with-libyaml-dir=/usr

# Copy app code
COPY --chown=solidus_user:solidus_user . .

# Install gems
RUN bundle install

CMD ["bash", "-c", "bundle exec rails s -b 0.0.0.0"]
