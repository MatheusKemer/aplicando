class DonesController < ApplicationController
  before_action :set_done, only: [:show, :edit, :update, :destroy]

  # GET /dones
  # GET /dones.json
  def index
    @dones = Done.all
  end

  # GET /dones/1
  # GET /dones/1.json
  def show
  end

  # GET /dones/new
  def new
    @done = Done.new
  end

  # GET /dones/1/edit
  def edit
  end

  def criar
    return unless user_signed_in?
    array = []  #Definindo um array vazio para jogar as respostas do aluno
    exam = Exam.find(params["prova_id"])
    total = exam.questions.count #Puxando o total de questões da prova a partir da prova_id nos params
    for i in 0..total-1 do #Fazendo um loop para percorrer cada questão
      array[i] = params["#{i}"]  #Jogando dentro do array as respostas do aluno, respeitando a poição de cada questão
    end  
    binding.pry
    Done.create exam_id: exam.id, students_id: current_user.id, respostas: array 
    certas = []
    i = 0
    exam.questions.each do |q|
      certas = q.id if q.correct == array[i].to_i
      i += 1 
    end 
    #10 divididos pelo número_questões para saber quanto vale cada questão
    binding.pry
    
  end

  # POST /dones
  # POST /dones.json
  def create
     
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
