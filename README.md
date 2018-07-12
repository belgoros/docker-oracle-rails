# README

It's a Rails application using Docker, [oracle_enhanced](https://github.com/rsim/oracle-enhanced) adapter, MRI Ruby 2.5.0.

1. Download the following zip archives from [Oracle Instant Client download page](http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html#ic_x64_inst):

- instantclient-basiclite-linux.x64-12.2.0.1.0.zip
- instantclient-sdk-linux.x64-12.2.0.1.0.zip
- instantclient-sqlplus-linux.x64-12.2.0.1.0.zip

2. Copy the above 3 archives into `<RAILS_APP_>/vendor` folder.
3. Open your Terminal and `cd` to the rails project.
4. Start `Docker` if it is not running.
5. Update `database.yml` configuration for your database, I used [Figaro](https://github.com/laserlemon/figaro) gem to keep ENV variables.
6. Run `docker build -t <name_you_like> .`
7. `ruby-oci8` gem should be installed without errors.
8. Run `docker run -p 3000:3000 <name_you_put_in_step_6` to start the rails app in the Docker container
9. Navigate to `localhost:3000` in your preferred browser.

For more details and options see [installation instructions in ruby-oci docs](https://www.rubydoc.info/github/kubo/ruby-oci8/file/docs/install-instant-client.md)
