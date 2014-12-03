class Fixquestions < ActiveRecord::Migration
  def change
  	change_table :questions do |t|
    t.remove :tag
    t.remove :category
  end
  end
end
