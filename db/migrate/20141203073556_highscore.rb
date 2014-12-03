class Highscore < ActiveRecord::Migration
  def change
  	  create_table :scores do |t|
      t.text :name
      t.integer :score

      t.timestamps
  end
  end
end
