class RemoveAnswerAndQuestionOnPuzzles < ActiveRecord::Migration[7.1]
  def change
    remove_column :puzzles, :answer
    remove_column :puzzles, :question
  end
end
