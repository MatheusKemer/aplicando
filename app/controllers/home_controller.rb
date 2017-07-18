class HomeController < ApplicationController

  def about
  end

  def faq
  end

  def save

  end

  def index
    redirect_to teachers_path if current_user.admin?
    @name = ' ' + (current_user.name.present? ? current_user.name : '')
  end
end
