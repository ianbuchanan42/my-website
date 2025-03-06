class PagesController < ApplicationController
  def home
    render Pages::HomeComponent.new
  end

  def about
    render Pages::AboutComponent.new
  end

  def experience
    render Pages::ExperienceComponent.new
  end

  def contact
    render Pages::ContactComponent.new
  end

  def send_contact_email
    # Here you would typically:
    # 1. Validate the parameters
    # 2. Send the email
    # 3. Handle any errors

    # For now, we'll just return a success response
    render json: { success: true }
  rescue StandardError => e
    render json: { success: false, message: e.message }, status: :unprocessable_entity
  end
end
