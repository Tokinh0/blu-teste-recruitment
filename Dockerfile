FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /test_recruitment
COPY Gemfile /test_recruitment/Gemfile
COPY Gemfile.lock /test_recruitment/Gemfile.lock
RUN bundle install
COPY . /test_recruitment

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]