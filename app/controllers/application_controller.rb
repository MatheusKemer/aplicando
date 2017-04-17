class ApplicationController < ActionController::Base
  include ApplicationHelper
  helper_method :current_user
  protect_from_forgery with: :exception
  #before_action :verify_user

  private
  def verify_user
	  if params["controller"].split('/').last != "sessions" 
	  	redirect_to 'user_session_path' unless user_signed_in?
	  end
  end
end
