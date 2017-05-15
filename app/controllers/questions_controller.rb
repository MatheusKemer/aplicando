class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :edit, :destroy, :update]

  def index
    redirect_to students_path if current_user.type == "Student"
    @question = Question.all
  end

  def like
    question_id = params["question"].to_i
    if Like.where(question_id: question_id, teacher_id: current_user.id).blank?
      Like.create question_id: question_id, teacher_id: current_user.id
    else
      Like.where(question_id: question_id, teacher_id: current_user.id).first.destroy
    end
    redirect_to :back
  end

  def dislike
    question_id = params["question"].to_i
    if Dislike.where(question_id: question_id, teacher_id: current_user.id).blank?
      Dislike.create question_id: question_id, teacher_id: current_user.id
    else
      Dislike.where(question_id: question_id, teacher_id: current_user.id).first.destroy
    end
    redirect_to :back
  end

  def find_question
  end

  def create
    @question = Question.new(question_attributes)
    @question.teacher_id = current_user.id
    if @question.correct.present?
      @question.correct = @question.answers[@question.correct.to_i]
    end
    #@answers.each {|a| @question.answers << a}
    if @question.save
      redirect_to questions_path, notice: "Sua questão foi cadastrada com sucesso"
    else
      flash[:error] = @question.errors.full_messages
      render :new
    end
  end

  def discover
    @question = Question.where(visible: true)
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
    binding.pry
    if Question.find(params[:id]).delete
      render text: "Questão: #{params[:id]} foi excluída com sucesso"
    else
      render text: "Não foi possível excluir a questão"
    end
  end


  private

  def question_attributes
    #@answers = []
    #params.each do |key, value|
    #  if ["0", "1", "2", "3", "4"].include? key
    #    @answers << value
    #  end
    #end
    question_attributes = params.require(:question).permit(:pergunta, :correct, :answers => [])
  end
end
