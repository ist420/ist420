class Employee < ActiveRecord::Base
    before_save {self.email = email.downcase }
    before_create :create_remember_token
    validates :password, length: {minimum: 6 }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
        format: { with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false }

  has_many :timestamps
  has_secure_password

  def Employee.new_remember_token
      SecureRandom.urlsafe_base64
  end

  def Employee.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
  end



  private
    def create_remember_token
        self.remember_token = Employee.encrypt(Employee.new_remember_token) 
    end
end
