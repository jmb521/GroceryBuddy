class BusinessesController < ApplicationController

    #don't need a new method because our create is taking care of createing all businesses through api
    def index
        @business = Business.find_by_zip(params[:search])
        if @business.empty?
            get_location = lat_long(params[:search])
        end

    end

   


    private

    def lat_long(zipcode)
        binding.pry
        Faraday.new("https://maps.googleapis.com/maps/api/geocode/json?key=#{google_api_key}&address=#{zipcode}")
    end
end
