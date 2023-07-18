# Cinema

Using **Ruby 3.0.1** with **Rails 6.1.4.1**

A simple Cinema API
- [Ruby challenge](https://gist.github.com/swistaczek/0fa028af47eb83d19b5da3e6d3092e63)

# Description

The simple Cinema API was built on [Ruby on Rails](https://github.com/rails/rails) framework.

It uses [PostgreSQL](https://www.postgresql.org/) for storing and fetching data.

It consists of multiple endpoints that are documented through [Swagger 2.0](https://swagger.io/specification/v2/)
and use the [Devise Auth token](https://github.com/lynndylanhurley/devise_token_auth) for authorization.

Users have multiple roles:
  - admin
  - customer

Customers do not have access to all of the endpoints, while admins have full access.

# How to run it

  1. Copy `.env.sample` and set it as `.env`

  2. Add all of the keys to the `.env`

  3. Run `bin/setup` for:
    - installing all of the dependencies through bundler (*version 2.2.15*)
    - running all of the migrations for the DB
    - removing old logs and tempfiles
    - populating the database

  4. Run `rails s` to run the *Cinema API*

# Info

The [Swagger 2.0](https://swagger.io/specification/v2/) documentation is available at `{host}/api-docs`, e.g. `localhost:3000/api-docs`, and the `swagger.yaml` file
is available at `spec/swagger/v1/swagger.yaml`

[SimpleCov](https://github.com/simplecov-ruby/simplecov) is used for test code coverage analysis. The generated `index.html` is available at  `coverage/index.html` (currently at **100%** code coverage).
The analysis can be opened independently from the project. New coverage analysis is generated after running all of the specs (tests).

To run all of the tests simply run `rspec` from the project root folder.

For linting run `rubocop`.

# Technical notes

- Gems used:
  - **DB**:
    - [pg](https://github.com/ged/ruby-pg) - adapter for PostgreSQL DB
  - **Authentication**:
    - [devise_auth_token](https://github.com/lynndylanhurley/devise_token_auth) - for auth token based authorizations
    - [rolify](https://github.com/RolifyCommunity/rolify) - for setting user roles (Usually paired with [cancancan](https://github.com/CanCanCommunity/cancancan))
  - **JSON API serializer**
    - [jsonapi-serializer](https://github.com/jsonapi-serializer/jsonapi-serializer) - for serializing data for response (*fork of Neftlix/fast_jsonapi*)
  - **Form and data validations**
    - [dry-validation](https://github.com/dry-rb/dry-validation) - for validating parameters types and setting rules
  - **API documentation (Swagger 2.0)**
    - [rswag](https://github.com/rswag/rswag) - for creating tests that generate *Swagger 2.0* documentation
  - **Bulk DB import**
    - [activerecord-import'](https://github.com/zdennis/activerecord-import) - for bulk importing data to DB
  - **Debugging**
    - [pry-rails](https://github.com/rweng/pry-rails) - for debugging
  - **Linting**
    - [rubocop](https://github.com/rubocop/rubocop) - linting and code formatter
  - **Testing**
    - [rspec-rails](https://github.com/rspec/rspec-rails) - testing framework
    - [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails) - for creating data for test DB
    - [forgery](https://github.com/sevenwire/forgery) - for faking test data values
    - [simplecov](https://github.com/simplecov-ruby/simplecov) - for analysing code coverage

**Service pattern**
For *create, update, delete* actions `service` pattern was used, e.g. `CreateUserMovieRating::EntryPoint`.
Stored in `units` folder, each unit is used for a single action and it's dependencies.
It's a great way for adding additional logic to all of the actions without making *controllers* "ugly".
The service is always called through its `::EntryPoint`, so when writing tests it is enough to just test all of the cases
from the `EntryPoint` file, e.g. `entry_point.spec`.
It can also be used for any logic that could be expanded upon, hence giving a easy and maintainable way of writing code.

**Swagger definitions**
All of the definitions are written in `*.yml` files (`spec/swagger/definitions`) after which they are ported and parsed in the `swagger_helper.rb` to the
`config.swagger_docs`.

**Tests - Authentication helper**
Helper methods are created for simple signing in a user, the helper generates and adds all of the needed headers for authenticating a user.
(`spec/support/requests/auth_helpers` - simply require and use `sign_in(user)`)
