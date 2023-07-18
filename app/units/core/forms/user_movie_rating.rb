# frozen_string_literal: true

module Core
  module Forms
    class UserMovieRating < BaseForm
      USER_MOVIE_RATING = 'user_movie_rating'
      MOVIE = 'movie'
      USER = 'user'

      params do
        required(:movie_id).filled(:integer)
        required(:user_id).filled(:integer)
        required(:rating).filled(:integer, gteq?: 1, lteq?: 5)
      end

      rule(:movie_id) do
        unless Movie.find_by(id: value).present?
          key.failure(I18n.t('.validation.errors.relation_not_exist',
                             relation: MOVIE))
        end
      end

      rule(:movie_id, :user_id) do
        key.failure(I18n.t('.validation.errors.already_exists', value: USER_MOVIE_RATING)) if ::UserMovieRating.find_by(
          movie_id: values[:movie_id], user_id: values[:user_id]
        ).present?
      end
    end
  end
end
