#Bikeshare

Bikeshare JSON API built with Sinatra. This application is intended to be run with MRI 2.3.0. To install dependencies:

```
bundle install
```

Run application:

```
rackup
```

Run specs:

```
rake
```

Alternatively:

```
rspec spec
```

This application uses an in-memory SQLite3 database for both development and test environments. All application state is lost when the server process ends.
