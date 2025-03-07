class ProjectComponent < ViewComponent::Base
  def initialize(title:, image_url: nil, summary:, tech_stack:, github_url: nil, website_url: nil)
    @title = title
    @image_url = image_url
    @summary = summary
    @tech_stack = tech_stack
    @github_url = github_url
    @website_url = website_url
  end

  def call
    tag.article(class: "bg-white rounded-lg shadow-md overflow-hidden flex flex-col") do
      safe_join([
        image_section,
        content_section
      ])
    end
  end

  private

  attr_reader :title, :image_url, :summary, :tech_stack, :github_url, :website_url

  def image_section
    return unless image_url.present? && valid_image_url?

    tag.figure(class: "relative w-full h-48 bg-gray-100") do
      image_tag(
        image_url,
        alt: title,
        class: "absolute inset-0 w-full h-full object-cover",
        loading: "lazy"
      )
    end
  end

  def content_section
    tag.div(class: "p-4 sm:p-6 flex flex-col flex-grow") do
      safe_join([
        title_section,
        summary_section,
        tech_stack_section,
        links_section
      ])
    end
  end

  def title_section
    tag.h3(title, class: "text-lg sm:text-xl font-bold mb-2")
  end

  def summary_section
    tag.p(summary, class: "text-sm sm:text-base text-gray-600 mb-4")
  end

  def tech_stack_section
    tag.div(class: "flex flex-wrap gap-2 mb-4", role: "list") do
      safe_join(
        tech_stack.map do |tech|
          tag.span(
            tech,
            class: [
              "px-2 sm:px-3 py-1 rounded-full text-xs sm:text-sm font-medium",
              tech_tag_color(tech)
            ].join(" "),
            role: "listitem"
          )
        end
      )
    end
  end

  def links_section
    return unless github_url || website_url

    tag.nav(class: "flex flex-wrap gap-4 mt-auto", role: "navigation", aria_label: "Project links") do
      safe_join([
        github_link,
        website_link
      ].compact)
    end
  end

  def github_link
    return unless github_url

    link_to(github_url, class: "inline-flex items-center text-sm sm:text-base text-gray-600 hover:text-gray-900", target: "_blank", rel: "noopener noreferrer", aria_label: "View #{title} on GitHub") do
      safe_join([
        github_icon,
        tag.span("View on GitHub", class: "ml-1")
      ])
    end
  end

  def website_link
    return unless website_url

    link_to(website_url, class: "inline-flex items-center text-sm sm:text-base text-gray-600 hover:text-gray-900", target: "_blank", rel: "noopener noreferrer", aria_label: "Visit #{title} website") do
      safe_join([
        website_icon,
        tag.span("Visit Website", class: "ml-1")
      ])
    end
  end

  def github_icon
    tag.svg(xmlns: "http://www.w3.org/2000/svg", class: "h-4 w-4 sm:h-5 sm:w-5", viewBox: "0 0 24 24", fill: "currentColor", aria_hidden: true) do
      tag.path(d: "M12 0C5.37 0 0 5.37 0 12c0 5.3 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61-.546-1.385-1.335-1.755-1.335-1.755-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 21.795 24 17.295 24 12c0-6.63-5.37-12-12-12")
    end
  end

  def website_icon
    tag.svg(xmlns: "http://www.w3.org/2000/svg", class: "h-4 w-4 sm:h-5 sm:w-5", viewBox: "0 0 24 24", fill: "currentColor", aria_hidden: true) do
      tag.path(d: "M12 2C6.477 2 2 6.477 2 12s4.477 10 10 10 10-4.477 10-10S17.523 2 12 2zm6.918 6h-3.215a23.262 23.262 0 00-1.658-4.087C16.709 4.859 18.877 6.097 18.918 8zm-7.918-4.99v4.99H7.082C7.123 6.097 9.291 4.859 11.955 3.913A23.262 23.262 0 0011 8.001V3.01zM4 12c0-.693.082-1.367.235-2h3.854c-.05.656-.089 1.324-.089 2s.039 1.344.089 2H4.235A7.963 7.963 0 014 12zm2.918 4h3.215c.406 1.519.958 2.878 1.658 4.087C9.291 19.141 7.123 17.903 7.082 16zm3.918 0h2v4.99C11.955 19.141 9.787 17.903 9.746 16H11v-4.99zM13 16h1.254c-.041 1.903-2.209 3.141-3.254 4.087V16h2zm1.835-2H11v-4h3.835c.05.656.089 1.324.089 2s-.039 1.344-.089 2zm.281-6H11V3.01c1.045.946 3.213 2.184 3.254 4.087L15.116 8zm3.599 6h-3.854c.05-.656.089-1.324.089-2s-.039-1.344-.089-2h3.854c.153.633.235 1.307.235 2s-.082 1.367-.235 2z")
    end
  end

  def tech_tag_color(tech)
    case tech.downcase
    when /html/
      "bg-[#E34F26]/10 text-[#D44320] border border-[#E34F26]/20" # Orange shade from HTML5 logo
    when /accessibility|a11y|wcag/i
      "bg-[#2A4365]/10 text-[#2C5282] border border-[#2A4365]/20" # Professional dark blue for accessibility
    when /css/
      "bg-[#1572B6]/10 text-[#0056B3] border border-[#1572B6]/20" # Blue shade from CSS3 logo
    when /javascript/
      "bg-[#F7DF1E]/10 text-[#947600] border border-[#F7DF1E]/20" # Yellow from JS logo with accessible text
    when /tailwind/
      "bg-[#38BDF8]/10 text-[#0284C7] border border-[#38BDF8]/20" # Tailwind's blue
    when /next\.?js/
      "bg-[#000000]/10 text-[#404040] border border-[#000000]/20" # Next.js black
    when /content.?management/i
      "bg-[#34D399]/10 text-[#047857] border border-[#34D399]/20" # Green for CMS
    when /ai|ml|machine.?learning/i
      "bg-[#8B5CF6]/10 text-[#6D28D9] border border-[#8B5CF6]/20" # Purple for AI/ML
    when /vs.?code/i
      "bg-[#007ACC]/10 text-[#0056B3] border border-[#007ACC]/20" # VS Code blue
    when /react/
      "bg-[#61DAFB]/10 text-[#087EA4] border border-[#61DAFB]/20" # React blue
    when /typescript/
      "bg-[#3178C6]/10 text-[#235A97] border border-[#3178C6]/20" # TypeScript blue
    when /vue\.?js/
      "bg-[#42B883]/10 text-[#2F855A] border border-[#42B883]/20" # Vue green
    when /koa\.?js/
      "bg-[#33333D]/10 text-[#1F1F29] border border-[#33333D]/20" # Koa's dark theme
    when /supabase/
      "bg-[#3ECF8E]/10 text-[#0F766E] border border-[#3ECF8E]/20" # Supabase green
    when /node\.?js/
      "bg-[#68A063]/10 text-[#2F6B29] border border-[#68A063]/20" # Node green
    else
      "bg-gray-100 text-gray-700 border border-gray-200"
    end
  end

  def valid_image_url?
    uri = URI.parse(image_url)
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end
end
