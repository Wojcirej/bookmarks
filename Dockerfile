FROM ruby:2.7.1

ENV RAILS_ENV=production
ENV RACK_ENV=production
ENV RAILS_LOG_TO_STDOUT="yes"

WORKDIR /usr/src/app

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get --yes install nodejs nano yarn

COPY Gemfile Gemfile.lock .ruby-gemset ./

RUN bundle install --without development test

COPY . .

RUN yarn install

EXPOSE 3000

CMD ["rails", "server", "--binding", "0.0.0.0", "--port", "3000"]