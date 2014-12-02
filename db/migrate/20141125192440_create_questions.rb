class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content
      t.string :correct
      t.text :fakes
      t.string :tag
      t.string :category
      t.decimal :times_used
      t.decimal :times_correct

      t.timestamps
    end
  end
end
