class SessionsController < Devise::SessionsController
  def logout
    sign_out(:user)
    redirect_to root_path
  end
end
