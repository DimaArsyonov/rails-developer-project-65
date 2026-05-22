# frozen_string_literal: true

100.times do
  file = Rails.root.join('db/seeds/files/bulletin_test.jpg').open
  uploaded = ActionDispatch::Http::UploadedFile.new(
    tempfile: file,
    filename: 'bulletin_test.jpg',
    content_type: 'image/jpeg'
  )
  bulletin = Bulletin.create!(
    title: Faker::Lorem.sentence(word_count: 2)[0, 30],
    description: Faker::Lorem.paragraph_by_chars(number: 256),
    user: User.first!,
    category: Category.first!,
    image: uploaded
  )

  case %i[draft under_moderation published rejected archived].sample
  when :under_moderation
    bulletin.to_moderate! if bulletin.may_to_moderate?
  when :published
    bulletin.to_moderate! if bulletin.may_to_moderate?
    bulletin.publish! if bulletin.may_publish?
  when :rejected
    bulletin.to_moderate! if bulletin.may_to_moderate?
    bulletin.reject! if bulletin.may_reject?
  when :archived
    bulletin.archive! if bulletin.may_archive?
  end
end
