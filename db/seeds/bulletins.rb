# frozen_string_literal: true

bulletin = Bulletin.new(
  title: Faker::Lorem.sentence,
  description: Faker::Lorem.paragraph_by_chars(number: 256),
  user: User.first,
  category: Category.first
)

bulletin.image.attach(
  io: File.open(Rails.root.join('db/seeds/files/bulletin_test.jpg')),
  filename: 'bulletin_test.jpg',
  content_type: 'image/jpeg'
)
bulletin.save!
