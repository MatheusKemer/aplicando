class Done < ApplicationRecord   
	serialize :respostas, Array   
	belongs_to :students, optional: true  
	belongs_to :exam, optional: true 
end
