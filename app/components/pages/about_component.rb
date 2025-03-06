class Pages::AboutComponent < BaseComponent
  def initialize
    super
    @title = "About Me"
    @content = "I am a passionate developer who loves building great software."
  end

  private

  attr_reader :title, :content
end
