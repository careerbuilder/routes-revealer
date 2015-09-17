[![Code Climate](https://codeclimate.com/repos/55fb0669695680114a000956/badges/8dcaf064da29d1a1e9b4/gpa.svg)](https://codeclimate.com/repos/55fb0669695680114a000956/feed)[![Test Coverage](https://codeclimate.com/repos/55fb0669695680114a000956/badges/8dcaf064da29d1a1e9b4/coverage.svg)](https://codeclimate.com/repos/55fb0669695680114a000956/coverage)[![Gem Version](https://badge.fury.io/rb/routes_revealer.svg)](http://badge.fury.io/rb/routes_revealer)
# routes_revealer
The routes revealer is a simple engine that adds a url to your rails application that will list all of the defined routes within your application.  This is especially useful if you are running in an environment where you have one website serviced by multiple backend applications.  

Imagine a scenario where you have two rails applications.  One is your main website and the other is a blog.  You could deploy both these apps with the routes revealer gem and then setup nginx, haproxy or Netflix zuul to query these apps for their defined urls and route to the appropriate one.  To your end-users it will appear as one unified website.


## Installation
To install this engine follow these steps:

1. Add the gem to your Gemfile ```gem 'routes_revealer'```
2. Add ``` mount RoutesRevealer::Engine => '/' ``` to config/routes.rb
3. ???
4. Profit!!


## Use
Go to your application's URL at /routes and you should see all of your routes in json like so
```js
["/assets","/","/home"]
```

Congratulations!
