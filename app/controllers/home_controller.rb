class HomeController < ApplicationController
  def index
    @locations = Location.all
    @events = Event.all
  end
end
