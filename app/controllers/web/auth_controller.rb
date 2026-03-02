class Web::AuthController < Web::ApplicationController
  def callback
    auth = request.env["omniauth.auth"]
    user = User.find_or_create_by(email: auth["info"]["email"], name: auth["info"]["name"])
    session[:user_id] = user.id
    redirect_to root_path, notice: "Signed in with #{auth["provider"]}!"
  end
end
