FROM ruby:3.1.2-bullseye

RUN apt-get update -qq && apt-get install -y \
  nodejs postgresql-client libyaml-dev build-essential git

RUN useradd -m -d /home/solidus_user solidus_user
USER solidus_user

WORKDIR /home/solidus_user/app
RUN git config --global --add safe.directory /home/solidus_user/app

COPY --chown=solidus_user:solidus_user . .

RUN bundle config build.psych --with-libyaml-dir=/usr && bundle install

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
