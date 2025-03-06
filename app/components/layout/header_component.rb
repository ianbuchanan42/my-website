class Layout::HeaderComponent < ViewComponent::Base
  def initialize(current_page:)
    @current_page = current_page
  end

  private

  attr_reader :current_page

  def nav_link_classes(path)
    base_classes = "px-3 py-2 rounded-md text-sm font-medium"
    if current_page == path
      "#{base_classes} bg-gray-900 text-white"
    else
      "#{base_classes} text-gray-300 hover:bg-gray-700 hover:text-white"
    end
  end
end
