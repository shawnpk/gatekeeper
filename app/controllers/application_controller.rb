class ApplicationController < ActionController::Base
  # include the Pundit module into the application for user permissions
  # including this module will include Pundit's helper methods
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
