class HomeController < ApplicationController
  
  def index
    @nav_pages = @static_pages
  end

end
