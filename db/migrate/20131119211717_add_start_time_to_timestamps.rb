class AddStartTimeToTimestamps < ActiveRecord::Migration
  def change
    add_column :timestamps, :start_time, :datetime
  end
end
