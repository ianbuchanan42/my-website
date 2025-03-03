if Rails.application.config.respond_to?(:vite_ruby)
  Rails.application.config.vite_ruby.tap do |config|
    # Set the source code directory
    config.source_code_dir = "app/frontend"
    
    # Configure public output directories
    config.public_dir = "public"
    config.public_output_dir = Rails.env.development? ? "vite-dev" : "vite-test"
    
    # Configure the port for the development server
    config.dev_server_port = 3036 if Rails.env.development?
    config.watch_additional_paths = []
  end
end 