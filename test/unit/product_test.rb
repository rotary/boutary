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

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
