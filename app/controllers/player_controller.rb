class PlayerController < ApplicationController
  layout 'player'

  def listen
    @autoplay = true
  end

end
