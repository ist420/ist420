class AddClientIdToTimestamps < ActiveRecord::Migration
  def change
    add_column :timestamps, :client_id, :integer
  end
end
