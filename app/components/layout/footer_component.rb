class Layout::FooterComponent < ViewComponent::Base
  def initialize
    @current_year = Time.current.year
  end

  private

  attr_reader :current_year
end 