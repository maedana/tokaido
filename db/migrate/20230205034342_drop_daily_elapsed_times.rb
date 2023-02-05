class DropDailyElapsedTimes < ActiveRecord::Migration[7.0]
  def up
    drop_table :daily_elapsed_times
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
