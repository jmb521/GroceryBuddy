class Business < ApplicationRecord
    has_many :business_items
    has_many :items, :through :business_items
end
