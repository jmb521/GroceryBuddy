class ApplicationController < ActionController::Base
  require 'figaro'
  require 'faraday'
  require 'json'

  before_action :configure_permitted_parameters, if: :devise_controller?
    
  def home
  
  end

  def after_sign_in_path_for(user)
    # get_all_stores
    home_path
  end

  private

  def get_results(all_stores)
    all_stores['results'].map { |store| create_store(store) }
  end

  def get_all_stores
    # binding.pry
    all_stores = get_stores(lat_long)
    def check_store(all_stores)
      if !all_stores.nil?
        get_results(all_stores)
        if all_stores.has_key?('next_page_token')
          next_store = get_next_page(all_stores['next_page_token'])
          check_store(next_store)
        end
      end
    end
    check_store(all_stores)
  end
  def create_store(store)
    address, city = store['vicinity'].split(', ')
    Business.find_or_create_by(
      name: store['name'],
      address: address,
      city: city,
      zipcode: current_user.zipcode
    )
  end

  def get_next_page(next_page_token)
    @result =
      Faraday.get(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{
          ENV['google_api_key']
        }&location=#{
          lat_long
        }&radius=1700&type=grocery_or_supermarket|pharmacy|food&next_page_token=#{
          next_page_token
        }"
      ) { |faraday| faraday.headers['Content-Type'] = 'application/json' }
    parsed = JSON.parse(@result.body)
  end

  def get_stores(lat_long)
    
    if !lat_long.nil?
      @result =
        Faraday.get(
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=#{
            ENV['google_api_key']
          }&location=#{
            lat_long
          }&radius=16094&type=grocery_or_supermarket|pharmacy|food"
        ) { |faraday| faraday.headers['Content-Type'] = 'application/json' }
      parsed = JSON.parse(@result.body)
    else
      nil
    end
  end
  def lat_long
    @result =
      Faraday.get(
        "https://maps.googleapis.com/maps/api/geocode/json?key=#{
          ENV['google_api_key']
        }&address=#{current_user.zipcode}"
      ) { |faraday| faraday.headers['Content-Type'] = 'application/json' }

    parsed = JSON.parse(@result.body)['results'][0]['geometry']['location']
    lat_long = "#{parsed['lat']} #{parsed['lng']}" if !parsed.nil?
  end


  

  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[first_name last_name city state zipcode]
    )
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[first_name last_name city state zipcode]
    )
  end
end
