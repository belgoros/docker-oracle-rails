FROM ruby:2.5.0

LABEL maintainer="Serguei Cambour <s.cambour@gmail.com"

RUN apt-get update -yqq
RUN apt-get install -yqq --no-install-recommends build-essential zip unzip libpq-dev libaio1 libaio-dev nodejs

ENV APP_HOME=/usr/src/app
ENV ORACLE_HOME=/opt/oracle
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_12_2

COPY . $APP_HOME

RUN mkdir -p $ORACLE_HOME
WORKDIR $ORACLE_HOME
RUN unzip $APP_HOME/vendor/instantclient-basiclite-linux.x64-12.2.0.1.0.zip
RUN unzip $APP_HOME/vendor/instantclient-sdk-linux.x64-12.2.0.1.0.zip
RUN unzip $APP_HOME/vendor/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip

RUN echo "$LD_LIBRARY_PATH"
#RUN ln -s $ORACLE_HOME/instantclient_12_2/libclntsh.so.12.1 libclntsh.so

RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc

WORKDIR $APP_HOME
RUN ln -s $ORACLE_HOME/instantclient_12_2/libclntsh.so.12.1 libclntsh.so && bundle install

RUN test -f tmp/pids/server.pid && rm -f tmp/pids/server.pid; true

CMD ["rails", "s", "-b", "0.0.0.0"]
