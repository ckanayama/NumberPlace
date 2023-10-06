class AddChallengeLevelToPuzzle < ActiveRecord::Migration[7.1]
  def change
    add_column :puzzles, :challenge_level, :integer, default: 0, null: false
  end
end
