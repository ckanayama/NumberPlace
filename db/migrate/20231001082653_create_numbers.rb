class CreateNumbers < ActiveRecord::Migration[7.1]
  def change
    create_table :numbers do |t|
      t.belongs_to :puzzle, null: false, foreign_key: true
      t.string :correct_answer, default: '', null: false
      t.string :question, default: '', null: false
      t.string :thinking_answer, default: '', null: false

      t.timestamps
    end
  end
end
