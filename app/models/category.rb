class Category < ApplicationRecord
  has_many :bulletins, dependent: :destroy

  validates :name, uniqueness: true, presence: true, length: { maximum: 50 }
end
