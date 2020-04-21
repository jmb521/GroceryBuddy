class BusinessItemsController < ApplicationController

    def new
        
        @business_items = BusinessItem.new
        @items = Item.all
        @business = Business.find(params[:business_id])
    end

    def create
        binding.pry
    end
end
