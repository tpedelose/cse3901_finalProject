class PlayController < ApplicationController

def index
	if (params[:question_id].present? && params[:answer].present?)
		@question = Question.find_by(id: params[:question_id])
		@user_answer = params[:answer]
		answer_array = @question.fakes.split(' ')
    answer_array.push(Question.find_by(id: params[:question_id]).correct)
    answer_array.push(params[:answer])
    @answer_array = answer_array.shuffle
	end
end

def start
	@id = Question.all.sort_by{rand}.slice(0).id
end

def get_input
	if params[:question_id].present?
		@question = Question.find_by(id: params[:question_id])
	end
end

def results
	if (params[:question_id].present? && params[:user_answer].present?)
		@question = Question.find_by(id: params[:question_id])
		@user_choice = params[:commit]
		@user_answer = params[:user_answer]
		if @question == (@user_answer)
			@winner = "<h1>Your correct!</h1>".html_safe
		end
		@answer = "The correct answer was #{@question.correct}"
		@id = Question.all.sort_by{rand}.slice(0).id
	end
end

  #def index             #equivalent to a "main" function
    # playing = 1         #this is the multiplier to points awarded; 1 = 1x, 2 = 2x, 0 <= not playing
    # @questions_used = Array.new{1}        #only needs to be server-side?
    # @user_points = 0    #this can be done on a per-session/per-x-time basis.
    # @answers=Answer.all

    # #while @questions_used.length < 10
    #   @question = choose_random_question
    #   @answer_array = seperate_answers

    #   #Start counter for time user hase to answer question
    #   start = Time.now
    #   @user_answer = nil
    #   #while ((Time.now - start) <= 15000 || @user_answer == nil) 
    #         #Will update to "15000 + question_read_time" later
    #     #!!! Probably needs to be done in Javascrpt  
    #     #done = Time.now
    #   #end
      

    #   time_left = 0
    #   if @user_answer != nil
    #     time_left = done - start
    #   end

    #   check_answer_and_award(playing, time_left)
    # #end
    # results
 # end

  # def get_input            #equivalent to a "main" function
  #   playing = 1         #this is the multiplier to points awarded; 1 = 1x, 2 = 2x, 0 <= not playing
  #   @questions_used = Array.new{1}        #only needs to be server-side?
  #   @user_points = 0    #this can be done on a per-session/per-x-time basis.
  #   @answers=Answer.all
  #   #while @questions_used.length < 10
  #     @current = session[:current]
  #     if @current > Question.count
  #       redirect_to play_results_path
  #       return
  #     end
  #     @question = Question.find(@current)
  #     @answer_array = seperate_answers

  #     #Start counter for time user hase to answer question
  #     start = Time.now
  #     done = nil
  #     #while (Time.now - start) <= 15000 #Will update to "15000 + question_read_time" later
  #       #!!! Probably needs to be done in Javascrpt  
  #       #done = Time.now
  #     #end
      

  #     time_left = 0
  #     if done != nil
  #       time_left = done - start
  #     end

  #     check_answer_and_award(playing, time_left)
  #   #end
  #   show_results
  # end



  # def set_user_answer
  #   @user_answer = params[:commit]
  # end

  # #Select final round question, etc
  # def final_round  #??? Need?

  # end

  # #Display round end results
  # def show_results
  #   # Will be a get method that displays new page with results
  # end

  # def answer
  #   useranswer=params[:answer]
  #   tag=params[:tag]
  #   @answer=Answer.create :content => useranswer, :tag => tag
  #   session[:current]+=1
  #   redirect_to play_get_input_path
  # end

  # #Helper methods that are only accessable from this controller
  # private

  #   #helper method that chooses new question randomly (need to limit to non-"final round" questions)
  #   def choose_random_question
  #     domanda = Question.all.sort_by{rand}.slice(0)
  #     while @questions_used.include?(domanda.id)
  #       domanda = Question.all.sort_by{rand}.slice(0)
  #     end

  #     #add the question id into array of used questions
  #     @questions_used << domanda.id
  #     return domanda
  #   end

  #   #seperates the @question.fakes string into an array of 5 random choices. Returns that array, randomized
  #   def seperate_answers
  #     temp_arr = @question.fakes.split "; " # contains fake answers 
      
  #     random_fakes = temp_arr.sort_by{rand}.slice(0,5) #finds 5 random fake answers
  #        #the end number will be updated to n+1 users when multiplayer is added
  #     random_fakes << @question.correct

  #     return random_fakes.sort_by{rand}
  #   end


  #   # Determines if user's answer is right and award points based on correctness, time left (ms)
  #   def check_answer_and_award multiplier, time_left
  #     if @user_answer == @question.correct
  #       correct_value = 1000 * multiplier
  #       #calculate points awarded here; use time left on clock, etc.
  #       @user_points = correct_value
  #     else #incorrect answer
  #       @user_points -= 500 * multiplier
  #     end
  #   end
  end