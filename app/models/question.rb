class Question < ActiveRecord::Base
	has_many :answers
	has_and_belongs_to_many :exams    
	belongs_to :professor

	validates :pergunta, presence: {message: "não pode ficar em branco"}, 
uniqueness: true
	
	validates :correct, presence: {message: " - é preciso ter uma resposta"}

  default_scope {order("pergunta ASC")}
  
  scope :recent, lambda {|x| order("created_at DESC").limit(x) }
  scope :recent_ten, -> { order("created_at DESC").limit(10) }
  
  def self.recent_ten
    order("created_at DESC").limit(10)
  end
  
  def self.recent(x)
    order("created_at DESC").limit(x)
  end

  before_save :capitalize_pergunta      


  private
  
  def capitalize_pergunta                
    self.pergunta.capitalize!
  end
end
