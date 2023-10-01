class AddStatusT < ActiveRecord::Migration[7.1]
  def change
    add_column :puzzles, :status, :integer, default: 0, null: false
  end
end
