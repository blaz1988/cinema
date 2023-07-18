# frozen_string_literal: true

module Core
  module Forms
    class MovieShowtime < BaseForm
      MOVIE = 'movie'

      params do
        required(:movie_id).filled(:integer)
        required(:showtime).filled(:date_time)
        optional(:ticket_price_pennies).filled(:integer, gteq?: 1)
      end

      rule(:movie_id) do
        unless Movie.find_by(id: value).present?
          key.failure(I18n.t('.validation.errors.relation_not_exist',
                             relation: MOVIE))
        end
      end

      rule(:showtime) do
        key.failure(I18n.t('.validation.errors.date_not_in_future')) if value.to_date.past?
      end
    end
  end
end
