# frozen_string_literal: true

module UpdateUserMovieRating
  class Form < Core::Forms::BaseForm
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
  end
end
