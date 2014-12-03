class AddCountToAnswers < ActiveRecord::Migration
  def change
  	  change_table :answers do |t|
      t.integer :count
      t.string :name
      t.integer :score
      t.string :gameid
      end
  end
end
