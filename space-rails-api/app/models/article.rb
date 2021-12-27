class Article < ApplicationRecord
    has_many :articles_events
    has_many :events, through: :articles_events

    has_many :articles_launches
    has_many :launches, through: :articles_launches
    
    validates :title, presence: true 
end
