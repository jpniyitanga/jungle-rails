require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validation" do   
    it "should create a product only if all validations are satisfied" do         
      @category = Category.new(name: "Test") 
      @product = Product.new(name: "Oak", price_cents: 10000, quantity: 10, :category => @category)
      @product.save
      expect(@product.errors.full_messages.length).to eq(0) 
    end

    it "should not create a product if no name is defined" do         
      @category = Category.new(name: "Test") 
      @product = Product.new(name: nil, price_cents: 10000, quantity: 10, :category => @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can\'t be blank") 
    end

    it "should not create a product if price is not defined" do         
      @category = Category.new(name: "Test") 
      @product = Product.new(name: nil, price_cents: nil, quantity: 10, :category => @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price can\'t be blank") 
    end

    it "should not create a product if quantity is not defined" do         
      @category = Category.new(name: "Test") 
      @product = Product.new(name: nil, price_cents: 10000, quantity: nil, :category => @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can\'t be blank") 
    end

    it "should not create a product if category is not defined" do
      
      @product = Product.new(name: nil, price_cents: 10000, quantity: nil, :category => nil)
      @product.save
      expect(@product.errors.full_messages).to include("Category can\'t be blank") 
    end

  end
end
