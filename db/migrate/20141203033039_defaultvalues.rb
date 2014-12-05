class Defaultvalues < ActiveRecord::Migration
  def change

  	change_column_default :questions, :times_used, 0
  	change_column_default :questions, :times_correct, 0
  end
end
