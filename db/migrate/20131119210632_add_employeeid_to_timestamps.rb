class AddEmployeeidToTimestamps < ActiveRecord::Migration
  def change
    add_column :timestamps, :employee_id, :integer
  end
end
