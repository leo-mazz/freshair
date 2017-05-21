class ErrorController < ApplicationController

  def not_found
    @title = 'Error 404'
    render(:status => 404)
  end

  def server_error
    @title = 'Error 500'
    render(:status => 500)
  end

  def teapot
    @title = '418'
    render(:status => 418)
  end

end
