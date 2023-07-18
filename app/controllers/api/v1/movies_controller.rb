# frozen_string_literal: true

module Api
  module V1
    class MoviesController < AuthenticationController
      before_action :set_movie, only: :show

      # GET /api/v1/movies
      def index
        movies = Movie.all

        render json: MovieSerializer.new(movies).serializable_hash if stale?(movies)
      end

      # GET /api/v1/movies/1
      def show
        render json: MovieSerializer.new(@movie).serializable_hash if stale?([@movie, @movie.rating])
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_movie
        @movie = Movie.find(params[:id])
      end
    end
  end
end
