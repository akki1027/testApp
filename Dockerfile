FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /testApp
WORKDIR /testApp
COPY Gemfile /testApp/Gemfile
COPY Gemfile.lock /testApp/Gemfile.lock
RUN gem install bundler -v 2.1.4
RUN gem install rails -v 6.0.3.3
RUN bundle install
COPY . /testApp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
