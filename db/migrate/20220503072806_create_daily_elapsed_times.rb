class CreateDailyElapsedTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :daily_elapsed_times do |t|
      t.string :uuid, null: false
      t.string :todo, null: false
      t.date :target_date, null: false
      t.integer :elapsed_seconds, null: false, default: 0

      t.timestamps

      t.index %i[uuid target_date], unique: true
      t.index :target_date
    end
  end
end
