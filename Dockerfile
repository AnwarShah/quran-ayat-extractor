FROM ruby:2.6.4

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle lock --add-platform ruby
RUN bundle lock --add-platform x86_64-linux
RUN bundle install

COPY . ./

CMD ["./fetch-ayat.rb"]

