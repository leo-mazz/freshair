class SubPagesController < ApplicationController

  def show
    @sub_page = SubPage.friendly.find(params[:id])
    @title = @sub_page.page.title + ' > ' + @sub_page.title
  end

end
