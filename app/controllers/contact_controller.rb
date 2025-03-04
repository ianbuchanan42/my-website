class ContactController < ApplicationController
  def index
  end

  def create
    # TODO: Implement email sending functionality
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "contact_form",
          partial: "contact/success_message"
        )
      end
    end
  end
end
