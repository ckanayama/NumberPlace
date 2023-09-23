class CreatePuzzles < ActiveRecord::Migration[7.1]
  def change
    create_table :puzzles do |t|
      t.integer :answer, array: true, default: [], null: false
      t.integer :question, array: true, default: [], null: false

      t.timestamps
    end
  end
end
