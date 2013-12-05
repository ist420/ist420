class Client < ActiveRecord::Base
    validates :name, presence: true
    has_many :timestamps
    validates :name, uniqueness: true

    def sum_hours
       sum = 0.0
       self.timestamps.each {|t| sum  += t.duration[:total]/60/60 }
       sum.round(2)
    end
    
end
