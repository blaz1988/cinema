# frozen_string_literal: true

class CreateUserMovieRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :user_movie_ratings do |t|
      t.integer :movie_id, null: false
      t.integer :user_id, null: false
      t.integer :rating, null: false

      t.timestamps
    end

    add_foreign_key :user_movie_ratings, :movies, column: :movie_id
    add_foreign_key :user_movie_ratings, :users, column: :user_id
  end
end
