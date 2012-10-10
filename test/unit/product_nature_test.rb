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

require 'test_helper'

class ProductNatureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
