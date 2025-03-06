class HomeController < ApplicationController
  def index
    render Pages::HomeComponent.new
  end
end
