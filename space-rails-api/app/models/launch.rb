class Launch < ApplicationRecord
    validates :origin_id, presence: true
    validates :provider, presence: true 
end
