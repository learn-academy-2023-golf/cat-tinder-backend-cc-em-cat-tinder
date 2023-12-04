class Toy < ApplicationRecord
    belongs_to :cat
    validates :name, :cat_id, presence: true
end
