class PlayController < ApplicationController

  def index
    @name = session[:username]
    @score = session[:score]
    @counter = session[:counter].to_i
    if (params[:question_id].present?)
      @question = Question.find_by(id: params[:question_id])
      #@answer=Answer.create :content => params[:answer].to_s.upcase, :tag => params[:question_id]
      @dbarray=Answer.all
      if params[:answer].present?
        @user_answer = params[:answer]
      else
        @user_answer = "NO INPUT"
      end
      answer_array=Array.new
      if Answer.where(:tag => params[:question_id].to_s).count < 4
        fill = @question.fakes.split('; ')
        fill.each do |x|
          Answer.create :content => x.upcase, :tag => params[:question_id]
        end
      end
      answer_array.push(Question.find_by(id: params[:question_id]).correct)
      if @question.correct.to_s != @user_answer.to_s.upcase
        if @user_answer != "NO INPUT"
          answer_array.push(@user_answer.to_s.upcase)
        else
          while answer_array.length <  2
            whiletemp=Answer.all.sort_by{rand}.slice(0)
            if !answer_array.include?(whiletemp.content) && whiletemp.tag==params[:question_id].to_s
              answer_array.push(whiletemp.content)
            end
          end
        end
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
    session[:counter] = 1
    session[:username]=nil
    session[:usedid] = Array.new
    session[:usedid].push(@id)
  end

  def get_input
    if session[:username]==nil
      session[:username] = params[:username].to_s
    end
    @name = session[:username]
    @score = session[:score].to_i
    @counter = session[:counter].to_i
    if params[:question_id].present?
      @question = Question.find_by(id: params[:question_id])
    end
  end

  def results
    @name = session[:username]
    if params[:user_answer].present?
      @user_answer = params[:user_answer].upcase
    else
      @user_answer = "NO ANSWER"
    end
    if params[:commit].present?
      @user_choice = params[:commit].upcase
    else
      @user_choice = "NO INPUT"
    end
    @answer=Answer.create :content => params[:commit].to_s.upcase, :tag => params[:question_id]
    if (params[:question_id].present? && params[:user_answer].present?)
      @question = Question.find_by(id: params[:question_id])
      #@user_choice = params[:commit].upcase
      #@user_answer = @user_answer.upcase
      if @question.correct == (@user_choice)
        @winnerselect = "<h1>Your answer selection was correct!</h1>".html_safe
        session[:score] = (session[:score].to_i + 100)
      end
      if @question.correct == (@user_answer)
        @winnerinput = "<h1>Your answer input was correct!</h1>".html_safe
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
    @counter = session[:counter].to_i
    @maximumarray= Answer.where(:tag => params[:question_id].to_s).uniq{|n| n.id}.order("count(content) DESC").to_a
    @maximum= Answer.where(:tag => params[:question_id].to_s).uniq{|n| n.id}.order("count(content) DESC").first
    @maximum.count=Answer.where(tag: params[:question_id].to_s, content:@maximum.content).count
    @maximumoutput="#{@maximum.content.to_s} was chosen #{@maximum.count.to_s}/#{Answer.count} times"
    @chart=""
    @maximumarray.each do |x|
      x.count=Answer.where(tag: params[:question_id].to_s, content:x.content).count
      if x.content==@question.correct
        @correctoutput="#{x.content.to_s} was chosen #{x.count.to_s}/#{Answer.count} times"
      end
      @chart+="['#{x.content}', x.count],\n"
    end
    session[:counter]+=1
    if session[:counter]>10
      @btn_js = "<script>$(document).ready(function(){$('#continue-form').hide();$('#stats-form').show();})</script>".html_safe
    else
      @btn_js = "<script>$(document).ready(function(){$('#stats-form').hide();$('#continue-form').show();})</script>".html_safe
    end
    @checkend=session[:counter]
  end

  def stats
    @score = session[:score]
    Scores.create :score => session[:score].to_i, :name => session[:username].to_s
    @highscores=Scores.order("score DESC").take(10)

  end
end
