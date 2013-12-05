class Timestamp < ActiveRecord::Base
  belongs_to :project
  belongs_to :employee
  belongs_to :client
  validates :employee_id, presence: true
  validates :project_id, presence: true
  validates :client_id, presence: true
  # attr_accessible :title, :body
  def duration
      duration = self.end_time - self.start_time
      {days: (duration/60/60/24).round, hours: (duration/60/60%24).round, minutes: (duration/60%60).round, seconds: (duration%60).round}
  end
  
  def closed?
      unless self.nil?
          !self.end_time.blank?
      else
          return true
      end
  end
end
