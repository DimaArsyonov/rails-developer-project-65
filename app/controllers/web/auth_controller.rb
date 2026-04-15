class Web::AuthController < Web::ApplicationController
  def callback
    auth = request.env["omniauth.auth"]
    user = User.find_or_create_by(email: auth["info"]["email"], name: auth["info"]["name"])
    session[:user_id] = user.id
    redirect_to root_path, notice: "#{t(:signed_in)} #{auth["provider"]}!"
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: "#{t(:signed_out)}"
  end
end
