class ProjectComponent < ViewComponent::Base
  def initialize(title:, image_url:, summary:, tech_stack:, github_url: nil, website_url: nil)
    @title = title
    @image_url = image_url
    @summary = summary
    @tech_stack = tech_stack
    @github_url = github_url
    @website_url = website_url
  end

  def call
    tag.article(class: "bg-white rounded-lg shadow-md overflow-hidden mb-8") do
      safe_join([
        image_section,
        content_section
      ])
    end
  end

  private

  attr_reader :title, :image_url, :summary, :tech_stack, :github_url, :website_url

  def image_section
    tag.div(class: "relative") do
      tag.img(src: image_url, alt: "#{title} project screenshot", class: "w-full h-48 object-cover")
    end
  end

  def content_section
    tag.div(class: "p-6") do
      safe_join([
        title_section,
        summary_section,
        tech_stack_section,
        links_section
      ])
    end
  end

  def title_section
    tag.h3(title, class: "text-2xl font-bold mb-2")
  end

  def summary_section
    tag.p(summary, class: "text-gray-600 mb-4")
  end

  def tech_stack_section
    tag.div(class: "flex flex-wrap gap-2 mb-4") do
      safe_join(
        tech_stack.map do |tech|
          tag.span(
            tech,
            class: [
              "px-3 py-1 rounded-full text-sm font-medium",
              tech_tag_color(tech)
            ].join(" ")
          )
        end
      )
    end
  end

  def tech_tag_color(tech)
    Rails.logger.debug "Processing tech tag: #{tech}"
    color = case tech.downcase
    when /react/
      "bg-[#61DAFB]/10 text-[#61DAFB] border border-[#61DAFB]/20"
    when /vue/
      "bg-[#42B883]/10 text-[#42B883] border border-[#42B883]/20"
    when /angular/
      "bg-[#DD0031]/10 text-[#DD0031] border border-[#DD0031]/20"
    when /ruby on rails/
      "bg-[#CC0000]/10 text-[#CC0000] border border-[#CC0000]/20"
    when /node/
      "bg-[#68A063]/10 text-[#68A063] border border-[#68A063]/20"
    when /javascript/
      "bg-[#F7DF1E]/10 text-[#F7DF1E] border border-[#F7DF1E]/20"
    when /typescript/
      "bg-[#3178C6]/10 text-[#3178C6] border border-[#3178C6]/20"
    when /html/
      "bg-[#E34F26]/10 text-[#E34F26] border border-[#E34F26]/20"
    when /css/
      "bg-[#1572B6]/10 text-[#1572B6] border border-[#1572B6]/20"
    when /postgresql/
      "bg-[#336791]/10 text-[#336791] border border-[#336791]/20"
    when /mongodb/
      "bg-[#47A248]/10 text-[#47A248] border border-[#47A248]/20"
    when /next/
      "bg-black/10 text-black border border-black/20"
    when /tailwind/
      "bg-[#38B2AC]/10 text-[#38B2AC] border border-[#38B2AC]/20"
    when /api/
      "bg-purple-100 text-purple-800 border border-purple-200"
    when /vs code/
      "bg-[#007ACC]/10 text-[#007ACC] border border-[#007ACC]/20"
    when /koa/
      "bg-[#68A063]/10 text-[#68A063] border border-[#68A063]/20"
    when /supabase/
      "bg-[#3ECF8E]/10 text-[#3ECF8E] border border-[#3ECF8E]/20"
    else
      "bg-gray-100 text-gray-800 border border-gray-200"
    end
    Rails.logger.debug "Selected color: #{color}"
    color
  end

  def links_section
    tag.div(class: "flex gap-4") do
      safe_join([
        github_link,
        website_link
      ].compact)
    end
  end

  def github_link
    return unless github_url

    link_to(github_url, class: "inline-flex items-center text-gray-600 hover:text-gray-900", target: "_blank", rel: "noopener noreferrer") do
      safe_join([
        github_icon,
        "View #{title} on GitHub"
      ])
    end
  end

  def website_link
    return unless website_url

    link_to(website_url, class: "inline-flex items-center text-blue-600 hover:text-blue-800", target: "_blank", rel: "noopener noreferrer") do
      safe_join([
        website_icon,
        "#{title} Website"
      ])
    end
  end

  def github_icon
    tag.svg(class: "w-5 h-5 mr-2", fill: "currentColor", viewBox: "0 0 24 24") do
      tag.path(d: "M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z")
    end
  end

  def website_icon
    tag.svg(class: "w-5 h-5 mr-2", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24") do
      tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14")
    end
  end
end
