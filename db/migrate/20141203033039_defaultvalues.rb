class Defaultvalues < ActiveRecord::Migration
  def change
  	change_column_default :answers, :count, 0
  end
end
