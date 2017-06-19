class DisciplinesController < ApplicationController
  before_action :set_discipline, only: [:show, :edit, :update, :destroy, :join, :exit]
  before_action :check_permission, only:  [:new, :create, :edit, :update, :destroy]

  # GET /disciplines
  # GET /disciplines.json
  def index
    @disciplines = Discipline.all
  end

  # GET /disciplines/1
  # GET /disciplines/1.json
  def show
  end

  def join
    return unless current_user.student?
    return redirect_to disciplines_path, alert: I18n.t("student.error.already_joined") unless
                                                       @discipline.add_students current_user
    respond_to do |format|
      if @discipline.save
        format.html { redirect_to disciplines_path, notice: I18n.t("student.alert.joined")}
        format.json { render :show, status: :created, location: @discipline }
      else
        #flash[:alert] = @discipline.errors.full_messages
        format.html { render :new }
        format.json { render json: @discipline.errors, status: :unprocessable_entity }
      end
    end
  end

  def exit
    return unless current_user.student? || @discipline.students.blank?
    @discipline.students = @discipline.students - [current_user] if @discipline.students.include? current_user
    respond_to do |format|
      if @discipline.save
        format.html { redirect_to disciplines_path, notice: "Student out successfully"}
      end
    end
  end

  # GET /disciplines/new
  def new
    @discipline = Discipline.new
  end

  # GET /disciplines/1/edit
  def edit
  end

  # POST /disciplines
  # POST /disciplines.json
  def create
    params = discipline_params
    @class_id = params.delete(:school_class)
    @class = SchoolClass.find_by ano: @class_id
    @discipline = Discipline.new(params)
    @discipline.school_class = @class
    @discipline.teacher_id = current_user.id
    respond_to do |format|
      if @discipline.save
        format.html { redirect_to @discipline, notice: 'Discipline was successfully created.' }
        format.json { render :show, status: :created, location: @discipline }
      else
        #flash[:alert] = @discipline.errors.full_messages
        format.html { render :new }
        format.json { render json: @discipline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disciplines/1
  # PATCH/PUT /disciplines/1.json
  def update
    respond_to do |format|
      if @discipline.update(discipline_params)
        format.html { redirect_to @discipline, notice: 'Discipline was successfully updated.' }
        format.json { render :show, status: :ok, location: @discipline }
      else
        format.html { render :edit }
        format.json { render json: @discipline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disciplines/1
  # DELETE /disciplines/1.json
  def destroy
    @discipline.destroy
    respond_to do |format|
      format.html { redirect_to disciplines_url, notice: 'Discipline was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discipline
      @discipline = Discipline.find_by_id(params[:id])
      redirect_to disciplines_path unless @discipline.present?
    end

    def check_permission
      redirect_to exams_path, flash: {alert: "Não permitido"} unless current_user.teacher? || current_user.admin?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discipline_params
      params.require(:discipline).permit(:name, :school_class)
    end
end
