class ApiController < ActionController::Metal
  include ActionController::Helpers
  include ActionController::Redirecting
  include ActionController::Rendering
  include ActionController::Renderers::All
  include ActionController::ConditionalGet

  include ActionController::MimeResponds
  #include ActionController::MimeResponds::ClassMethods #respond_to
  include ActionController::RequestForgeryProtection
  #include ActionController::Base
  #include ActionController::HttpAuthentication::Basic 
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  include ActionController::ForceSSL
  include AbstractController::Callbacks

  include ActionController::Instrumentation

  include ActionController::ParamsWrapper

  include Rails.application.routes.url_helpers

  append_view_path "#{Rails.root}/app/views"

  wrap_parameters format: [:json]

  # protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
  #with: :exception
        
        
end