class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.decimal :score
      t.decimal :count
      t.string :answer
      t.string :people_fooled
      t.decimal :num_people_fooled
      t.string :game_id

      t.timestamps
    end
  end
end
