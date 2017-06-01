class DonesController < ApplicationController
  before_action :set_done, only: [:show, :edit, :update, :destroy]
  before_action :verify_user

  # GET /dones GET /dones.json
  def index
    redirect_to exams_path
  end

  # GET /dones/1
  # GET /dones/1.json
  def show
    redirect_to exams_path
  end

  # GET /dones/new
  def new
    redirect_to exams_path
  end

  # GET /dones/1/edit
  def edit
    redirect_to exams_path
  end

  def criar
    return unless user_signed_in?
    array = []  #Definindo um array vazio para jogar as respostas do aluno
    exam = Exam.find(params["prova_id"])
    total = exam.questions.count #Puxando o total de questões da prova a partir da prova_id nos params
    for i in 0..total-1 do #Fazendo um loop para percorrer cada questão
      array[i] = params["#{i}"]  #Jogando dentro do array os ID's das respostas do aluno, respeitando a posição de cada questão
    end
    @done = Done.new(exam_id: exam.id, student_id: current_user.id, respostas: array) #Criando tabela respostas
    @done.finished_at = Time.current
    #@done.save! if Done.where(exam_id: exam.id, student_id: current_user.id).blank? #Verificando se já não há respostas do aluno para essa prova
    #nota = calcular_nota
    certas = [] #criando o array onde será inserido os ID's das questões corretas
    i = 0 # Definindo um contador
    exam.questions.each do |q|
      certas << q.id if q.correct == q.answers[array[i].to_i] #Comparando se o ID da resposta correta da questão é o mesmo que o ID que o aluno escolheu
      i += 1
    end
    each_question_value = 10/total
    nota = certas.size*each_question_value
    #10 divididos pelo número_questões para saber quanto vale cada questão
    @done.nota = nota
    if @done.save
      flash[:notice] = "Finalizada"
      redirect_to @done
    else
      flash[:notice] = @done.errors.full_messages
      redirect_to @done
    end
  end

  # POST /dones
  # POST /dones.json
  def create
    binding.pry
    if Done.where(exam_id: exam.id, student_id: current_user.id).any?
      @done = Done.new(done_params)

      respond_to do |format|
        if @done.save
          format.html { redirect_to @done, notice: 'Done was successfully created.' }
          format.json { render :show, status: :created, location: @done }
        else
          format.html { render :new }
          format.json { render json: @done.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /dones/1
  # PATCH/PUT /dones/1.json
  def update
    respond_to do |format|
      if @done.update(done_params)
        format.html { redirect_to @done, notice: 'Done was successfully updated.' }
        format.json { render :show, status: :ok, location: @done }
      else
        format.html { render :edit }
        format.json { render json: @done.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dones/1
  # DELETE /dones/1.json
  def destroy
    return
    @done.destroy
    respond_to do |format|
      format.html { redirect_to dones_url, notice: 'Done was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_done
      @done = Done.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def done_params
      params.require(:done).permit(:respostas)
    end
end
