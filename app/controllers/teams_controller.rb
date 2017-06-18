class TeamsController < ApplicationController

  def show
    @team = Team.friendly.find(params[:id])
    @team_posts = @team.posts.order(created_at: :desc)
  end

end
