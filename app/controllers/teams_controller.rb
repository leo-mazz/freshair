class TeamsController < ApplicationController

  def show
    @team = Team.friendly.find(params[:id])
    @team_posts = @team.posts.order(created_at: :desc).limit(6)

    @tags  = {}

    @team.tags.each do |tag|
      @tags[tag] = tag.posts.where(team_id: @team.id).limit(6)
    end

    @latest_podcast = nil
    @latest_podcast = @team.hub_show.podcasts.last unless @team.hub_show.blank?

    @title = @team.name
  end

  def all_posts
    @team = Team.friendly.find(params[:id])
    @team_posts = @team.posts.order(created_at: :desc).page(params[:page])

  end

end
