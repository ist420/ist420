class AddStartTimeToTimestamps < ActiveRecord::Migration
  def change
    add_column :timestamps, :start_time, :time
  end
end
