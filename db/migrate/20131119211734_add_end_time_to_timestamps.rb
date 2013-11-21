class AddEndTimeToTimestamps < ActiveRecord::Migration
  def change
    add_column :timestamps, :end_time, :time
  end
end
