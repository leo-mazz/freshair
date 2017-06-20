class TeamsController < ApplicationController

  def show
    @team = Team.friendly.find(params[:id])
    @team_posts = @team.posts.order(created_at: :desc)

    @tags  = {}

    @team.tags.each do |tag|
      @tags[tag] = tag.posts.where(team_id: @team.id).limit(6)
    end
  end

end
