class AddProjectIdToTimestamps < ActiveRecord::Migration
  def change
    add_column :timestamps, :project_id, :integer
  end
end
