# frozen_string_literal: true

require 'tempfile'

def random_bulletin_state(bulletin)
  return unless bulletin.may_to_moderate?

  bulletin.to_moderate!
  apply_random_action(bulletin)
end

def apply_random_action(bulletin)
  case rand(3)
  when 0 then bulletin.publish! if bulletin.may_publish?
  when 1 then bulletin.reject! if bulletin.may_reject?
  when 2 then bulletin.archive! if bulletin.may_archive?
  end
end

source_path = Rails.root.join('db/seeds/files/bulletin_test.jpg')
file_content = File.read(source_path)

100.times do
  tempfile = Tempfile.new(['bulletin', '.jpg'], binmode: true)
  tempfile.write(file_content).rewind
  uploaded = ActionDispatch::Http::UploadedFile.new(
    tempfile: tempfile,
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
  random_bulletin_state(bulletin)
end
