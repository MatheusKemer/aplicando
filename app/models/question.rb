class Question < ActiveRecord::Base
  serialize :answers, Array
	has_and_belongs_to_many :exams
	belongs_to :teacher

	validates :pergunta, presence: {message: "não pode ficar em branco"},
uniqueness: true


  before_save :capitalize_pergunta
  validate :check_correct
  validate :count_answers
  before_destroy :delete_likes_dislikes

  def likers
    Like.where(question_id: id).map {|t| t.teacher.name}
  end

  def dislikers
    Dislike.where(question_id: id).map {|t| t.teacher.name}
  end

  def answers_empty?
    val = self.answers.map {|a| false if a.empty?}
    if val.empty?
      true
    else
      val.include? false
    end
  end

  private

  def delete_likes_dislikes
    @question = self
    Like.where(question_id: @question.id).destroy_all
    Dislike.where(question_id: @questoin_id).destroy_all
  end

  def count_answers
    val = self.answers.map {|a| false if a.empty?}
    if val.include? false
      errors.add(:base, "É preciso ter 5 respostas")
    end

  end

  def capitalize_pergunta
    self.pergunta.capitalize!
  end

  def check_correct
    @question = self
    if @question.answers.map{|a| a}.include? @question.correct
      return
    else
      errors.add(:base, I18n.t("error.teste"))
      return
    end
  end

end
