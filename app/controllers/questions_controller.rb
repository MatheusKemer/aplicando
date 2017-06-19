class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :destroy, :update]
  before_action :set_user_type

  def index
    redirect_to students_path if current_user.type == "Student"
    redirect_to teachers_path if current_user.type == "Admin"
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

  def list_questions
    @questions = Question.where discipline_id: params[:discipline_id]
    render :layout => false
  end

  def create
    attributes = question_attributes
    get_class_and_discipline attributes.delete(:discipline)
    @question = Question.new(attributes)
    #@question.school_class = @school_class
    @question.discipline = @discipline
    @question.teacher_id = current_user.id
    @question.created_at = Time.current
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

  def update
    #@question = Question.find(question_url.split('/').last.to_i)
    @question.update(question_attributes)
    if @question.correct.present?
      @question.correct = @question.answers[@question.correct.to_i]
    end
    if @question.save!
      redirect_to questions_path(@question)
    else
      flash[:error] = @question.errors.full_messages
      render :edit
    end
  end

  def discover
    return @questions = Question.all if current_user.admin?
    @questions = Question.all
    @teacher_questions = current_user.questions
    @questions = @questions - @teacher_questions
    @questions.map {|q| q if q.visible == true}
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
    if Question.find(params[:id]).delete
      render text: "Question: #{params[:id]} was successfully excluded"
    else
      render text: "There was a problem excluding your question"
    end
  end


  private

  def set_user_type
    user = current_user
    user.type ||= "Student"
    user.save
  end

  def get_class_and_discipline(param)
    param = param.split '-'
    @discipline = Discipline.find_by name: param.last
    @school_class = param.first
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_attributes
    params.require(:question).permit(:discipline, :pergunta, :correct, :answers => [])
  end
end
