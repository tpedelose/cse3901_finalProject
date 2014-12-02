class PlayController < ApplicationController

  def index             #equivalent to a "main" function
    @playing = 1         #this is the multiplier to points awarded; 1 = 1x, 2 = 2x, 0 <= not playing
    @questions_used = Array.new{1}        #only needs to be server-side?
    @user_points = 0    #this can be done on a per-session/per-x-time basis.

    #while @questions_used.length < 10
    @question = choose_random_question
    @answer_array = seperate_answers

    #Start counter for time user hase to answer question
    start = Time.now
    @user_answer = nil
    #while ((Time.now - start) <= 15000 || @user_answer == nil) 
        #Will update to "15000 + question_read_time" later
      #!!! Probably needs to be done in Javascrpt  
      #done = Time.now
    #end
      
    time_left = 0
    if @user_answer != nil
      time_left = done - start
    end

    check_answer_and_award time_left
  end

  #controls the get input view.
  def get_input            #equivalent to a "main" function
    playing = 1         #this is the multiplier to points awarded; 1 = 1x, 2 = 2x, 0 <= not playing
    @questions_used = Array.new{1}        #only needs to be server-side?
    @user_points = 0    #this can be done on a per-session/per-x-time basis.

    #while @questions_used.length < 10
    @question = choose_random_question
    @answer_array = seperate_answers

    #Start counter for time user hase to answer question
    start = Time.now
    done = nil
    #while (Time.now - start) <= 15000 #Will update to "15000 + question_read_time" later
      #!!! Probably needs to be done in Javascrpt  
      #done = Time.now
    #end
      

    time_left = 0
    if done != nil
      time_left = done - start
    end

    #check_answer_and_award time_left
  end

  #display results until user presses button to play again/go home?
  def results             #equivalent to a "main" function

  end

  def set_user_answer
    @user_answer = params[:commit]
  end

  #Select final round question, etc
  def final_round  #??? Need?

  end

  def answer
    useranswer=params[:answer]
    tag=params[:tag]
    @answer=Answer.create :content => useranswer, :tag => tag
    redirect_to :action => "get_input"
  end

  #Helper methods that are only accessable from this controller
  private

    #helper method that chooses new question randomly (need to limit to non-"final round" questions)
    def choose_random_question
      domanda = Question.all.sort_by{rand}.slice(0)
      while @questions_used.include?(domanda.id)
        domanda = Question.all.sort_by{rand}.slice(0)
      end

      #add the question id into array of used questions
      @questions_used << domanda.id
      return domanda
    end

    #seperates the @question.fakes string into an array of 5 random choices. Returns that array, randomized
    def seperate_answers
      temp_arr = @question.fakes.split "; " # contains fake answers 
      
      random_fakes = temp_arr.sort_by{rand}.slice(0,5) #finds 5 random fake answers
         #the end number will be updated to n+1 users when multiplayer is added
      random_fakes << @question.correct

      return random_fakes.sort_by{rand}
    end


    # Determines if user's answer is right and award points based on correctness, time left (ms)
    def check_answer_and_award time_left
      if @user_answer == @question.correct
        correct_value = 1000 * @playing       
        #calculate points awarded here; use time left on clock, etc.
        @user_points = correct_value
      else #incorrect answer
        @user_points -= 500 * @playing
      end
    end
  end