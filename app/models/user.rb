class User < ApplicationRecord
  has_secure_password
  
validates :email, presence: true, uniqueness: { case_sensitive: false }
validates :first_name, presence: true
validates :last_name, presence: true
validates :password, presence: true, length: {minimum: 6} 
validates :password_confirmation, presence: true, length: {minimum: 6} 

  def authenticate_with_credentials(email, password) 
    return nil if email != self.email || self.password != password  
    self
  end
end
