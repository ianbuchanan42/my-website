class Pages::ContactComponent < BaseComponent
  def initialize
    super
    @title = "Contact Me"
    @email = "get.ian.buchanan@gmail.com"
    @social_links = [
      { name: "GitHub", url: "https://github.com/yourusername" },
      { name: "LinkedIn", url: "https://linkedin.com/in/yourusername" },
      { name: "Twitter", url: "https://twitter.com/yourusername" }
    ]
  end

  private

  attr_reader :title, :email, :social_links
end
