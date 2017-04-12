class ProvasController < ApplicationController     
	def show
		@prova = Prova.all
		 
	end

	def index
		@prova = Prova.all
	end

	def create
		@prova = Prova.new
	end
end