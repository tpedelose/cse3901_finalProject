class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :passcode
      t.decimal :max_players
      t.decimal :max_observers
      t.text :players
      t.text :observers
      t.decimal :status

      t.timestamps
    end
  end
end
