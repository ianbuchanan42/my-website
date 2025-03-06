class Pages::HomeComponent < BaseComponent
  def initialize
    super
    @title = "Welcome to My Website"
    @subtitle = "This is a Rails application with RSpec and Selenium testing."
  end

  private

  attr_reader :title, :subtitle
end
