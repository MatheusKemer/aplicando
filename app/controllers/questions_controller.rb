class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :edit, :destroy, :update]

  def index
    @question = Question.all
  end

  def create
    @question = Question.new(question_attributes)
    if @question.save
      redirect_to questions_path, notice: "Sua questão foi cadastrada com sucesso"
    else
      flash.now[:error] = "Erro ao cadastrar"
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def destroy
    render text: "Questão: #{params[:id]} foi excluída com sucesso"
  end


  private

  def question_attributes
    question_attributes = params.require(:question).permit([:title,:description])
  end
end
