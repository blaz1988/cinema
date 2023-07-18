# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :name, null: false
      t.date :release_date
      t.string :description
      t.float :imdb_rating, precision: 2, scale: 2
      t.string :runtime

      t.timestamps
    end
  end
end
