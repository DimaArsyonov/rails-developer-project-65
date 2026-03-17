require "test_helper"

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)

    @attrs = {
      title: @bulletin.title,
      description: @bulletin.description,
      image: fixture_file_upload("bulletin_test.jpg", "image/jpeg")
    }
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
    post bulletins_url, params: { bulletin: @attrs }

    bulletin = Bulletin.find_by(@attrs.except(:image))

    assert { bulletin }
    assert_redirected_to bulletin_url(bulletin)
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
    patch bulletin_url(@bulletin), params: { bulletin: { description: @bulletin.description, title: @bulletin.title } }
    assert_redirected_to bulletin_url(@bulletin)
  end

  test "should destroy bulletin" do
    assert_difference("Bulletin.count", -1) do
      delete bulletin_url(@bulletin)
    end

    assert_redirected_to bulletins_url
  end
end
