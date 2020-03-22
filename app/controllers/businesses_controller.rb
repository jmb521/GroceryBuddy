class BusinessesController < ApplicationController
  before_action :get_all_stores
  def index
    @business = Business.find_by_zip(current_user.zipcode)
  end

  #
  #
  #             if !all_stores.nil?
  #                 if all_stores.has_key?("next_page_token")
  #                     result << get_results(all_stores, params[:search])

  #                     all_stores = get_next_page(all_stores[0]["next_page_token"])
  #                     get_all_stores
  #                 else
  #                     result << get_results(all_stores, business_params)
  #                     # redirect_to businesses_path

  #                 end
  #             end

  #         else

  #         end
  #         result
  #     end
  #     binding.pry
  #    @business = get_all_stores

  # end

  private

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

  def create_store(store)
    address, city = store['vicinity'].split(', ')
    Business.find_or_create_by(
      name: store['name'],
      address: address,
      city: city,
      zipcode: current_user.zipcode
    )
  end

  def business_params
    params.require(:business).permit(
      :name,
      :type,
      :address,
      :city,
      :state,
      :zipcode,
      :search
    )
  end

  def get_results(all_stores)
    all_stores['results'].map { |store| create_store(store) }
  end

  def get_all_stores
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
  end
end
