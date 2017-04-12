class HomeController < ApplicationController         

  def about
  end
  
  def faq
  end

  def save
  	 
  end

  def index
  	@exam = Exam.first
  end
end
