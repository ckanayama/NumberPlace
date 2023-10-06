class CreateSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :settings do |t|
      t.integer :challenge_level, default: 0, null: false
      t.integer :theme, default: 0, null: false

      t.timestamps
    end
  end
end
