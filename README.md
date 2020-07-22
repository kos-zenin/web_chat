# Web Chat

## This is an application implementing web chat.

- [x] Users must be able to create an account providing a valid email address.
- [x] Once logged in users must be able to send and receive messages.
- [x] It has only one channel/room and all the users subscribed will have access to the only available channel

The system sends to all the users a weekly emails:
 - [ ] how many messages were sent and received in the last week
 - [ ] the total number of messages received since the user has sent his last message

# Setup

1. Install ruby 2.7.1
2. `gem install bundler`
3. `bundle install`
4. `cp .env .env.development`
5. Add necessary variables to `.env.development` file
6. `bundle exec rails db:create RAILS_ENV=development`
7. `rails server`

# Dependencies

- postgresql
- redis

# Tests

## Setup

1. `cp .env .env.test`
2. Add necessary variables to `.env.test` file

## Run

1. `bundle exec rspec`
2. `bundle exec rubocop`
