class Pages::ExperienceComponent < BaseComponent
  def initialize
    super
    @title = "My Experience"
    @experiences = [
      {
        title: "Software Engineer",
        company: "Example Corp",
        period: "2020 - Present"
      }
    ]
  end

  private

  attr_reader :title, :experiences
end
