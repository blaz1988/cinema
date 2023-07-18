# frozen_string_literal: true

module Api
  module V1
    class MovieShowtimesController < AuthenticationController
      before_action :set_movie_showtime, only: %i[show update destroy]
      before_action :authenticate_admin_user!, only: %i[create update destroy]

      # GET /api/v1/movie_showtimes
      def index
        movie_showtimes = MovieShowtime.all

        render json: MovieShowtimeSerializer.new(movie_showtimes).serializable_hash if stale?(movie_showtimes)
      end

      # GET /api/v1/movie_showtimes/1
      def show
        render json: serialized_movies if stale?(@movie_showtime)
      end

      # POST /api/v1/movie_showtimes
      def create
        @movie_showtime = CreateMovieShowtime::EntryPoint.new(params: movie_showtime_params).call

        render json: serialized_movies, status: :created
      end

      # PATCH/PUT /api/v1/movie_showtimes/1
      def update
        @movie_showtime = UpdateMovieShowtime::EntryPoint.new(params: movie_showtime_params,
                                                              movie_showtime: @movie_showtime).call

        render json: serialized_movies
      end

      # DELETE /api/v1/movie_showtimes/1
      def destroy
        @movie_showtime = DestroyMovieShowtime::EntryPoint.new(movie_showtime: @movie_showtime).call
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_movie_showtime
        @movie_showtime = MovieShowtime.find(params[:id])
      end

      def serialized_movies
        MovieShowtimeSerializer.new(@movie_showtime).serializable_hash
      end

      def movie_showtime_params
        params[:data][:attributes].to_h
      end
    end
  end
end
