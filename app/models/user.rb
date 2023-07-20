class User < ApplicationRecord
  has_secure_password
  
validates :email, presence: true, uniqueness: { case_sensitive: false }
validates :first_name, presence: true
validates :last_name, presence: true
validates :password, presence: true, length: {minimum: 6} 
validates :password_confirmation, presence: true, length: {minimum: 6} 

  def self.authenticate_with_credentials(email, password) 
    # require "pry"; binding.pry
    @user = self.where("lower(email) = ?", email.delete(" ").downcase).first.try(:authenticate, password)   
  end
end
