# frozen_string_literal: true

module Tasks
  class PopulateDatabase
    include Rake::DSL

    IMDB_MOVIE_IDS = %w[
      tt0232500
      tt0322259
      tt0463985
      tt1013752
      tt1596343
      tt1905041
      tt2820852
      tt4630562
    ].freeze

    ADMIN_USER = {
      email: 'admin@test.com',
      password: 'secret'
    }.freeze

    CUSTOMER_USER = {
      email: 'customer@test.com',
      password: 'secret'
    }.freeze

    def initialize
      namespace :populate_database do
        desc 'populate DB with movies from OMDB and add Admin user and Customer'
        task run: :environment do
          movies = []

          puts 'Populating started...'
          IMDB_MOVIE_IDS.each do |imdb_id|
            movie = FetchDataFromOpenMovie::EntryPoint.new(imdb_id: imdb_id).call
            puts movie['Title']
            movies << Movie.new(parse_data(movie))
          end

          puts 'Importing movies...'
          Movie.import movies

          puts 'Adding users...'
          add_admin_user
          add_customer_user

          puts 'Finished'
        end
      end
    end

    private

    def parse_data(data)
      {
        name: data['Title'],
        release_date: data['Released'],
        description: data['Plot'],
        runtime: data['Runtime'],
        imdb_rating: data['imdbRating']
      }
    end

    def add_admin_user
      admin_user = User.new(ADMIN_USER)
      admin_user.save
      admin_user.add_role :admin
    end

    def add_customer_user
      customer_user = User.new(CUSTOMER_USER)
      customer_user.save
      customer_user.add_role :customer
    end
  end
end

Tasks::PopulateDatabase.new
