FROM ruby:3.1.2-bullseye

# Instala dependencias del sistema
RUN apt-get update -qq && apt-get install -y \
  nodejs postgresql-client libyaml-dev build-essential git

# Crea el usuario de la app
RUN useradd -m -d /home/solidus_user solidus_user

# Cambia al usuario de la app
USER solidus_user

# Define el directorio de trabajo
WORKDIR /home/solidus_user/app

# Marca el directorio como seguro para Git
RUN git config --global --add safe.directory /home/solidus_user/app

# ⬇️ AQUÍ VA EL COPY
COPY --chown=solidus_user:solidus_user . .

# Configura bundler para psych y ejecuta instalación
RUN bundle config build.psych --with-libyaml-dir=/usr && bundle install

# Comando para iniciar el servidor
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
