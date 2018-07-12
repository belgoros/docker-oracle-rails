FROM ruby:2.5.0

LABEL maintainer="Serguei Cambour <s.cambour@gmail.com"

RUN apt-get update -yqq
RUN apt-get install -yqq --no-install-recommends build-essential libpq-dev libaio1 libaio-dev alien dpkg-dev debhelper rpm nodejs

ENV APP_HOME /usr/src/app

COPY . $APP_HOME
WORKDIR $APP_HOME/vendor

# Convert the package.rpm into a package.deb and install the generated package.
RUN alien -i oracle-instantclient12.2-basiclite-12.2.0.1.0-1.x86_64.rpm
RUN alien -i oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm
RUN alien -i oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm

RUN export ORACLE_HOME=/opt/oracle/12_2/instantclient
RUN export PATH=/opt/oracle/instantclient_12_2:$PATH
RUN export PATH=/usr/lib/oracle/12.2/client64/bin:$PATH
RUN export LD_LIBRARY_PATH=/usr/lib/oracle/12.2/client64/lib:$LD_LIBRARY_PATH

RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc

WORKDIR $APP_HOME
RUN bundle install

RUN test -f tmp/pids/server.pid && rm -f tmp/pids/server.pid; true

RUN ["chmod", "+x", "entrypoint.sh"]
CMD ["./entrypoint.sh"]
