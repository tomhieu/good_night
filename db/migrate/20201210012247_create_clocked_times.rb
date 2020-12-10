class CreateClockedTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :clocked_times do |t|
      t.string :action
      t.references :sleep, null: false, foreign_key: true

      t.timestamps
    end
  end
end
