class ApplicationController < ActionController::Base
  include ApplicationHelper
  helper_method :current_user
  before_action :authenticate_user!
  before_action :set_locale
  protect_from_forgery with: :exception
  #load_and_authorize_resource
  #before_action :verify_user
  skip_before_filter :verify_authenticity_token

  def teste
    current_user.update locale: current_user.locale == "en" ? "pt-BR" : "en"
  end

  private

  def set_locale
    I18n.locale = current_user.try(:locale) || "pt-BR"
  end
  def verify_user
	  if params["controller"].split('/').last != "sessions"
	  	redirect_to 'new_user_session_path' unless user_signed_in?
	  end
  end
end
