class Defaultvalues < ActiveRecord::Migration
  def change
   	change_column_default :players, :count, 0
  	change_column_default :players, :score, 0
  	change_column_default :players, :num_people_fooled, 0

  	change_column_default :questions, :times_used, 0
  	change_column_default :questions, :times_correct, 0
  end
end
