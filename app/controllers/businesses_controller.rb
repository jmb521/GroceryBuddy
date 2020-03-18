class BusinessesController < ApplicationController

    #don't need a new method because our create is taking care of createing all businesses through api
    def index
        business = Business.find_by_zip(params[:search])
        if business.empty?
            get_location = lat_long(params[:search])
            
        end

    end

   


    private

    def lat_long(zipcode)
        zipcode = 60504
        @result = Faraday.get("https://maps.googleapis.com/maps/api/geocode/json?key=#{ENV['google_api_key']}&address=#{zipcode}") do |faraday|
            faraday.headers['Content-Type'] = 'application/json'
        end
        parsed = JSON.parse(@result.body)["results"][0]["geometry"]["location"]
        lat_long = "#{parsed["lat"]} #{parsed["lng"]}"
        get_stores(lat_long)
    end
    
    def get_stores(lat_long)
        binding.pry

    end

end
