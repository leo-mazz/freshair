class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
    @title = 'Events > ' + @event.name
  end
  
end
