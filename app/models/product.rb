# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  nature_id   :integer          not null
#  name        :string(255)      not null
#  description :text
#  arity       :integer
#  amount      :decimal(16, 2)
#

class Product < ActiveRecord::Base
  belongs_to :nature, :class_name => "ProductNature"
  attr_accessible :nature_id, :name, :description, :arity, :amount
  default_scope order(:name)
  alias_attribute :resident_number, :arity
  validates_presence_of :arity, :amount

end
