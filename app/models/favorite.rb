class Favorite < ApplicationRecord
    belongs_to :user
    belongs_to :books
    validates :user_id, presence: true
    validates :book_id, presence: true
end
