class PlayController < ApplicationController

  def index
    @score = session[:score]
  	if (params[:question_id].present? && params[:answer].present?)
  		@question = Question.find_by(id: params[:question_id])
      @answer=Answer.create :content => params[:answer].to_s.upcase, :tag => params[:question_id]
      @dbarray=Answer.all
      @user_answer = params[:answer]
      answer_array=Array.new
      if Answer.where(:tag => params[:question_id].to_s).count < 6
        fill = @question.fakes.split('; ')
        fill.each do |x|
          Answer.create :content => x, :tag => params[:question_id]
        end
      end
      answer_array.push(Question.find_by(id: params[:question_id]).correct)
      if @question.correct.to_s != params[:answer].to_s.upcase
        answer_array.push(params[:answer].to_s.upcase)
      end
      while answer_array.length < 6 
        whiletemp=Answer.all.sort_by{rand}.slice(0)
        if !answer_array.include?(whiletemp.content) && whiletemp.tag==params[:question_id].to_s
          answer_array.push(whiletemp.content)
        end
      end
      @answer_array = answer_array.shuffle
  	end
  end

  def start
  	@id = Question.all.sort_by{rand}.slice(0).id
    session[:score] = 0
    session[:usedid] = Array.new
    session[:usedid].push(@id)
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
      while session[:usedid].include?(@id) && session[:usedid].length < Question.all.count
        @id = Question.all.sort_by{rand}.slice(0).id
      end
      session[:usedid].push(@id)
  	end
    @score = session[:score]
  end
end
