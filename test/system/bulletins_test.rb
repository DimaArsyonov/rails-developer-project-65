require "application_system_test_case"

class BulletinsTest < ApplicationSystemTestCase
  setup do
    @bulletin = bulletins(:one)

    @category = categories(:one)

    @bulletin.image.attach(
      io: File.open(Rails.root.join("test/fixtures/files/bulletin_test.jpg")),
      filename: "bulletin_test.jpg",
      content_type: "image/jpeg"
    )

    @user = users(:one)

    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      provider: "github",
      uid: @user.id,
      info: {
        email: @user.email,
        name: @user.name
      }
    )

    visit callback_auth_url(provider: "github")
  end

  test "visiting the index" do
    visit bulletins_url
    assert_selector "h1", text: I18n.t(:bulletins)
  end

  test "should create bulletin" do
    visit bulletins_url
    click_on I18n.t(:add_bulletin)

    fill_in "Description", with: @bulletin.description
    fill_in "Title", with: @bulletin.title
    attach_file "bulletin_image", Rails.root.join("test/fixtures/files/bulletin_test.jpg")
    find("select[name='bulletin[category_id]']").find("option[value='#{@category.id}']").select_option
    click_on I18n.t(:create_bulletin)

    assert_text I18n.t(:bulletin_created)
    click_on "Back"
  end

  test "should update Bulletin" do
    visit bulletin_url(@bulletin)
    click_on "Edit this bulletin", match: :first

    fill_in "Description", with: @bulletin.description
    fill_in "Title", with: @bulletin.title
    click_on I18n.t(:update_bulletin)

    assert_text I18n.t(:bulletin_updated)
    click_on "Back"
  end
end
