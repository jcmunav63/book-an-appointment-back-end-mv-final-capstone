module Api
  module V1
    class CitiesController < ApplicationController
      before_action :set_city, only: [:show]

      def index
        state = State.includes(:cities).find(params[:state_id])
        cities = state.cities.map do |city|
          {
            id: city.id,
            city_name: city.name,
            state_name: state.name,
            state_abbrev: state.abbrev
          }
        end
        render json: cities, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'State not found' }, status: :not_found
      end

      def show
        render json: @city
      end

      private

      def set_city
        @city = City.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'City not found' }, status: :not_found
      end
    end
  end
end
