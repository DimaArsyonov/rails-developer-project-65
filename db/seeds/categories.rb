# frozen_string_literal: true

return if Category.exists?

Category.create!(name: Faker::Lorem.characters(number: 10))
Category.create!(name: Faker::Lorem.characters(number: 10))
Category.create!(name: Faker::Lorem.characters(number: 10))
Category.create!(name: Faker::Lorem.characters(number: 10))
Category.create!(name: Faker::Lorem.characters(number: 10))
Category.create!(name: Faker::Lorem.characters(number: 10))
