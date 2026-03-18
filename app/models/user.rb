class User < ApplicationRecord
  has_many :bulletins, dependent: :destroy

  validates :name, presence: true, allow_nil: true
  validates :email, presence: true, uniqueness: true
end
