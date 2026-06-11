# frozen_string_literal: true

class Web::AuthControllerTest < ActionDispatch::IntegrationTest
  test 'check github auth' do
    post auth_request_path('github')
    assert_response :redirect
  end

  test 'create' do
    email = Faker::Internet.email

    auth_hash = {
      provider: 'github',
      uid: '12345',
      info: {
        email: email,
        name: Faker::Name.first_name
      }
    }

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(auth_hash)

    post auth_request_path('github', email: email)
    follow_redirect!

    assert_response :redirect

    user = User.find_by(email: email.downcase)

    assert user
    assert signed_in?
  end
end
