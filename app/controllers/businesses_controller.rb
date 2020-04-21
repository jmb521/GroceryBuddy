class BusinessesController < ApplicationController
  # before_action :get_all_stores

  def index
    
    @business = Business.all
    @items = Item.all
  end

  def search
    @business = Business.find_by_zip(params[:zip])
    render :index
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

end
