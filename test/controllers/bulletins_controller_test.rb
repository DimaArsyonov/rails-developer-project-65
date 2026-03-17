require "test_helper"

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)

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

    get callback_auth_url(provider: "github")
  end

  test "should get index" do
    get bulletins_url
    assert_response :success
  end

  test "should get new" do
    get new_bulletin_url
    assert_response :success
  end

  test "should create bulletin" do
    file = fixture_file_upload(Rails.root.join("test/fixtures/files/bulletin_test.jpg"), "image/jpeg")

    assert_difference("Bulletin.count") do
      post bulletins_url, params: { bulletin: { description: @bulletin.description, title: @bulletin.title, category_id: categories(:one).id, image: file } }
    end

    assert_redirected_to bulletin_url(Bulletin.last)
  end

  test "should show bulletin" do
    get bulletin_url(@bulletin)
    assert_response :success
  end

  test "should get edit" do
    get edit_bulletin_url(@bulletin)
    assert_response :success
  end

  test "should update bulletin" do
    file = fixture_file_upload(Rails.root.join("test/fixtures/files/bulletin_test.jpg"), "image/jpeg")
    patch bulletin_url(@bulletin), params: { bulletin: { description: @bulletin.description, title: @bulletin.title,  image: file } }
    assert_redirected_to bulletin_url(@bulletin)
  end

  test "should destroy bulletin" do
    assert_difference("Bulletin.count", -1) do
      delete bulletin_url(@bulletin)
    end

    assert_redirected_to bulletins_url
  end
end
