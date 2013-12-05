class Client < ActiveRecord::Base
    validates :name, presence: true
    has_many :timestamps
    validates :name, uniqueness: true

    
end
