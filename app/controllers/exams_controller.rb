class ExamsController < ApplicationController
  before_action :set_exam, only: [:show, :edit, :update, :destroy]
  before_action :check_permission, only:  [:new, :create, :edit, :update, :destroy]

  # GET /exams
  # GET /exams.json
  def index
    @exams = Exam.where(teacher_id: current_user.id) if current_user.teacher?
    @exams = Exam.all
  end

  # GET /exams/1
  # GET /exams/1.json
  def show
    done = Done.find_by student_id: current_user.id, exam_id: @exam.id
    redirect_to done_path(done.id) if done.present?
  end

  # GET /exams/new
  def new
    @exam = Exam.new
    @questions = Teacher.find(current_user.id).questions
  end

  # GET /exams/1/edit
  def edit
    @questions = Teacher.find(current_user.id).questions
  end

  def all
  end

  # POST /exams
  # POST /exams.json
  def create
    params = exam_params
    @discipline = params.delete(:discipline)
    @exam = Exam.new(params)
    @exam.teacher_id = current_user.id
    @exam.discipline = Discipline.find_by name: @discipline
    @exam.questions = @questions_id.map {|id| Question.find_by_id id}
    @exam.created_at = Time.current
    respond_to do |format|
      if @exam.save
        format.html { redirect_to @exam, notice: 'Exam was successfully created.' }
        format.json { render :show, status: :created, location: @exam }
      else
        format.html { render :new }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exams/1
  # PATCH/PUT /exams/1.json
  def update
    respond_to do |format|
      if @exam.update(exam_params)
        format.html { redirect_to @exam, notice: 'Exam was successfully updated.' }
        format.json { render :show, status: :ok, location: @exam }
      else
        format.html { render :edit }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.json
  def destroy
    @exam.destroy
    respond_to do |format|
      format.html { redirect_to exams_url, notice: 'Exam was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find_by_id(params[:id])
      redirect_to exams_path if @exam.nil?
    end

    def check_permission
      redirect_to exams_path, flash: {alert: "Não permitido"} if current_user.student?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exam_params
      @questions_id = []
      discipline = Discipline.find_by name: params[:exam][:discipline]
      Question.where(teacher_id: current_user.id, discipline: discipline).each do |q|
        @questions_id << q.id if params["#{q.id}"] == "true"
      end
      params.require(:exam).permit(:id, :title, :discipline)
    end
end
