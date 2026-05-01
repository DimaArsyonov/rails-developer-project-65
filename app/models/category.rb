class Category < ApplicationRecord
  has_many :bulletins, dependent: :restrict_with_error

  validates :name, uniqueness: true, presence: true, length: { maximum: 50 }
end
