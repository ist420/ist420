class Timestamp < ActiveRecord::Base
  belongs_to :project
  belongs_to :employee
  validates_presence_of :employee
  # attr_accessible :title, :body
end
