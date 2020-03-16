class BusinessItem < ApplicationRecord
    belongs_to :user
    belongs_to :item
    belongs_to :business
end
