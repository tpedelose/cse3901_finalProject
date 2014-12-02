class Answers < ActiveRecord::Migration
  def change
  	  create_table :answers do |t|
      t.text :content
      t.string :tag

      t.timestamps
    end
  end
end
