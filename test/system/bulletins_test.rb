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

    @bulletin.save!

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
    visit root_path
    assert_selector "h2", text: I18n.t(:bulletins)
  end

  test "should create bulletin" do
    visit root_path
    click_on I18n.t(:add)

    fill_in I18n.t("simple_form.labels.bulletin.description"), with: @bulletin.description
    fill_in I18n.t("simple_form.labels.bulletin.title"), with: @bulletin.title
    attach_file I18n.t("simple_form.labels.bulletin.image"), Rails.root.join("test/fixtures/files/bulletin_test.jpg")
    find("select[name='bulletin[category_id]']").find("option[value='#{@category.id}']").select_option
    click_on I18n.t("helpers.submit.create", model: I18n.t("activerecord.models.bulletin"))

    assert_text I18n.t(:bulletin_created)
  end

  test "should update Bulletin" do
    visit profile_url
    click_on I18n.t(:edit)

    fill_in I18n.t("simple_form.labels.bulletin.description"), with: @bulletin.description
    fill_in I18n.t("simple_form.labels.bulletin.title"), with: @bulletin.title
    click_on I18n.t("helpers.submit.update", model: I18n.t("activerecord.models.bulletin"))

    assert_text I18n.t(:bulletin_updated)
  end
end
