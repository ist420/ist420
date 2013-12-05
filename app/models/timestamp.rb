class Timestamp < ActiveRecord::Base
  belongs_to :project
  belongs_to :employee
  belongs_to :client
  validates :employee_id, presence: true

  # attr_accessible :title, :body
end
