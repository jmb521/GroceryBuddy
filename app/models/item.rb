class Item < ApplicationRecord
    has_many :business_items

    def get_availability(business)
        
        self.business_items.where(:business_id => business.id).order(created_at: :asc).limit(1)
    end
end
