class Project < ActiveRecord::Base
    has_many :timestamps
    validates :name, presence: true
    validates :name, uniqueness: true

end
