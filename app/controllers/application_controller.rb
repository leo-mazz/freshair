class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_globals


  private

  def set_globals
    # We need to set these globally so that the sidebar and main menu can access
    # them from anywhere
    @upcoming_events = Event.all_upcoming
    @tweets = TwitterService.get_timeline
    @static_pages = Page.all.order(priority: :desc)
  end
end
