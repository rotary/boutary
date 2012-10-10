# == Schema Information
#
# Table name: product_natures
#
#  id               :integer          not null, primary key
#  name             :string(255)      not null
#  description      :text
#  payment_sequence :string(255)
#  initial_quantity :integer
#  current_quantity :integer
#

class ProductNature < ActiveRecord::Base
  attr_accessible :name, :description, :payment_sequence, :initial_quantity
end
