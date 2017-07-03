class PlayerController < ApplicationController
  layout 'player'

  def listen
    # Allow embedding on other websites
    response.headers.delete "X-Frame-Options"
  end

end
