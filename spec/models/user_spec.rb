require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation" do 
    it "should create a user only if all validations are satisfied" do 
      @user = User.new(email: "me@email.com", password: "123456", password_confirmation: "123456", first_name: "User_FirstName", last_name: "User_LastName")
      @user.save 
      expect(@user.errors.full_messages.length).to eq(0) 
    end

    it "should not create a user if email is not provided" do 
      @user = User.new(email: nil, password_confirmation: "123456", first_name: "User_FirstName", last_name: "User_LastName")
      @user.save 
      expect(@user.errors.full_messages).to include("Email can\'t be blank") 
    end

    it "should not create a user if password is not provided" do 
      @user = User.new(email: "me@email.com", password: nil, password_confirmation: "123456", first_name: "User_FirstName", last_name: "User_LastName")
      @user.save 
      expect(@user.errors.full_messages).to include("Password can\'t be blank") 
    end

    it "should not create a user if password is not long enough" do 
      @user = User.new(email: "me@email.com", password: "12345", password_confirmation: "12345", first_name: "User_FirstName", last_name: "User_LastName")
      @user.save 
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)") 
    end

    it "should not create a user if password_confirmation is not provided" do 
      @user = User.new(email: "me@email.com", password: "123456", password_confirmation: nil, first_name: "User_FirstName", last_name: "User_LastName")
      @user.save 
      expect(@user.errors.full_messages).to include("Password confirmation can\'t be blank") 
    end

    it "should not create a user if password doesn't match with password_confirmation" do 
      @user = User.new(email: "me@email.com", password: "123456", password_confirmation: "654321", first_name: "User_FirstName", last_name: "User_LastName")
      @user.save 
      expect(@user.errors.full_messages).to include("Password confirmation doesn\'t match Password") 
    end

    it "should not create a user if first name is not provided" do 
      @user = User.new(email: "me@email.com", password: "123456", password_confirmation: "123456", first_name: nil, last_name: "User_LastName")
      @user.save 
      expect(@user.errors.full_messages).to include("First name can\'t be blank") 
    end

    it "should not create a user if last name is not provided" do 
      @user = User.new(email: "me@email.com", password: "123456", password_confirmation: "123456", first_name: "User_FirstName", last_name: nil)
      @user.save 
      expect(@user.errors.full_messages).to include("Last name can\'t be blank") 
    end

    it "should not create a user if email was already used" do 
      @user5 = User.new(email: "user6@email.com", password: "123456", password_confirmation: "123456", first_name: "fname_5", last_name: "lname_5")
      @user5.save 
      @user6 = User.new(email: "user6@email.com", password: "123456", password_confirmation: "123456", first_name: "fname_6", last_name: "lname_6")
      @user6.save 
      expect(@user6.errors.full_messages).to include("Email has already been taken") 
    end

    it "should return null if not authenticated" do       
      user = User.new(email: "user6@email.com", password: "123456", password_confirmation: "123456", first_name: "fname_6", last_name: "lname_6") 
      expect(user.authenticate_with_credentials("test@email.com", "123456")).to be_nil 
    end 

    it "should return user if authenticated" do       
      user = User.new(email: "user6@email.com", password: "123456", password_confirmation: "123456", first_name: "fname_6", last_name: "lname_6") 
      expect(user.authenticate_with_credentials("user6@email.com", "123456")).not_to be_nil 
    end


  end
end
