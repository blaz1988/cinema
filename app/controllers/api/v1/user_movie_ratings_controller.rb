# frozen_string_literal: true

module Api
  module V1
    class UserMovieRatingsController < AuthenticationController
      before_action :set_user_movie_rating, only: [:update]

      # POST /api/v1/user_movie_ratings
      def create
        @user_movie_rating = CreateUserMovieRating::EntryPoint
                             .new(params: user_movie_rating_params.merge(user_id: current_api_v1_user.id)).call

        render json: serialized_user_movie_rating, status: :created
      end

      # PATCH/PUT /api/v1/user_movie_ratings/1
      def update
        @user_movie_rating = UpdateUserMovieRating::EntryPoint
                             .new(params: user_movie_rating_params.merge(user_id: current_api_v1_user.id),
                                  user_movie_rating: @user_movie_rating).call

        render json: serialized_user_movie_rating
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_user_movie_rating
        @user_movie_rating = UserMovieRating.find(params[:id])
      end

      def serialized_user_movie_rating
        UserMovieRatingSerializer.new(@user_movie_rating).serializable_hash
      end

      def user_movie_rating_params
        params[:data][:attributes].to_h
      end
    end
  end
end
