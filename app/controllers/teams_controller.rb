class TeamsController < ApplicationController

  def show
    @team = Team.friendly.find(params[:id])
  end

end
