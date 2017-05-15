class ApplicationController < ActionController::Base
  include ApplicationHelper
  helper_method :current_user
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  #load_and_authorize_resource
  #before_action :verify_user

  private
  def verify_user
	  if params["controller"].split('/').last != "sessions"
	  	redirect_to 'new_user_session_path' unless user_signed_in?
	  end
  end
end
