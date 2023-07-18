# frozen_string_literal: true

class CreateMovieShowtimes < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_showtimes do |t|
      t.integer :movie_id, null: false
      t.datetime :showtime, null: false
      t.integer :ticket_price_pennies, default: 0

      t.timestamps
    end

    add_foreign_key :movie_showtimes, :movies, column: :movie_id
  end
end
