class Business < ApplicationRecord
    has_many :business_items
    has_many :items, :through => :business_items

    scope :find_by_zip, ->(zip) {where(:zipcode => zip)}
end
