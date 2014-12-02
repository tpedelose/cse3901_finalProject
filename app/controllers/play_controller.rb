class PlayController < ApplicationController
  def index
    @score = session[:score]
  	if (params[:question_id].present? && params[:answer].present?)
  		@question = Question.find_by(id: params[:question_id])
  		@user_answer = params[:answer]
  		answer_array = @question.fakes.split(',')
      answer_array.push(Question.find_by(id: params[:question_id]).correct)
      answer_array.push(params[:answer])
      @answer_array = answer_array.shuffle
  	end
  end

  def start
  	@id = Question.all.sort_by{rand}.slice(0).id
    session[:score] = 0
  end

  def get_input
    @score = session[:score].to_i
  	if params[:question_id].present?
  		@question = Question.find_by(id: params[:question_id])
  	end
  end

  def results
  	if (params[:question_id].present? && params[:user_answer].present?)
  		@question = Question.find_by(id: params[:question_id])
  		@user_choice = params[:commit]
  		@user_answer = params[:user_answer]
  		if @question.correct == (@user_choice)
  			@winner = "<h1>Your correct!</h1>".html_safe
        session[:score] = (session[:score].to_i + 100)
  		end
  		@answer = "The correct answer was #{@question.correct}"
  		@id = Question.all.sort_by{rand}.slice(0).id
  	end
    @score = session[:score]
  end
end