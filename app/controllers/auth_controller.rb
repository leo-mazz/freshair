class AuthController < ApplicationController

  def test
    authenticate_user!
    if user_signed_in?
      head :ok
    else
      head :unauthorized
    end
  end

end
