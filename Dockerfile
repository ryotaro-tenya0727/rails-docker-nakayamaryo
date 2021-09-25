FROM ruby:2.7
#curl ~ でhttpリクエストの結果の標準出力を標準入力としてapt-keyに渡している。

ENV RAILS_ENV=production

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  #echo ~ を標準入力として tee に渡している。
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn
WORKDIR /app
COPY ./src/ /app
RUN bundle install

COPY start.sh /start.sh
RUN chmod 744 /start.sh
CMD ["sh","/start.sh"]
