class PlayerController < ApplicationController

  skip_before_action :verify_authenticity_token
  layout 'player'

  def listen
    @title = 'Player'
    # Allow embedding on other websites
    response.headers.delete "X-Frame-Options"
  end

end
