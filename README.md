# Fortune: A sample pseudo-random subscription website

## How it works

User submits her email.  System sends out a confirmation email.  User visits the confirmation link sent in the email.  Once confirmed, the user is then sent a new quote every day.


<hr />

## Development setup

### Dependencies

1. Ruby 2.2.2
2. Postgressql 9.4.1
3. Nginx ( Passenger will install this for you, see "Starting and running the server" section below
3. For other dependecies, check out [Gemfile][gemfile]

### Technologies used

1. Ruby 2.2.2
2. Rails 4.2.4
3. Postgressql 9.4.1
4. Twitter Bootstrap Sass for styling
5. Stock image from http://thestocks.im/
6. Qotd from free qotd servers listed here: https://en.wikipedia.org/wiki/QOTD
7. Rspec for testing
8. Sidekiq for async jobs

### Setup

1. Clone the repo, and `cd` into the repo
2. Run `bundle install`
3. `rake db:create`
4. `rake db:migrate` ( OR `rake db:schema:load` depending on your preference )

### Testing &amp; QA

1. `rake db:migrate RAILS_ENV=test`
2. `bundle exec rspec` to run the test-suite
3. Project uses Rubocop to conform to community accepted style guide. Some exceptions are made based on personal preferences. Check out the `.rubocop.yml` file for these exceptions.

### Starting and running the server

1. `bundle exec passenger start` ( At this point, passenger may install a few missing dependencies )
2. `bundle exec sidekiq -c 5` to start the Sidekiq worker process
3. Navigate to `http://localhost:3000`

### Publishing the Newsletter

`rake publish`

This publishes the newest edition of the newsletter. Following things happen:

1. Gets a fresh, random quote from a [pre-configured][qotd-code] [QOTD][qotd-wiki] server.
2. Checks for eligible subscriptions
3. Sends out email to them
4. This task is idempotent, and can be safely run multiple times.

<hr />

## Future Scope

1. Add different types of pseudo-random sources ( Images, Music, Books, Videos etc )
2. Add profile edit and other social media features
3. Add Facebook, Twitter integration and "Share" functionality
4. Add permalinks and "view in browser" feature for emails


[gemfile]: https://github.com/swanandp/fortune/blob/master/Gemfile
[qotd-code]: https://github.com/swanandp/fortune/blob/master/app/models/qotd.rb
[qotd-wiki]: https://en.wikipedia.org/wiki/QOTD
