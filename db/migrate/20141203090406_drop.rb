class Drop < ActiveRecord::Migration
  def change
  	drop_table :games

  	change_table :answers do |t|
    t.remove :gameid
    t.remove :score
    end
  end
end
