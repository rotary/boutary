# == Schema Information
#
# Table name: sales
#
#  id               :integer          not null, primary key
#  product_id       :integer          not null
#  number           :string(255)
#  amount           :decimal(16, 2)
#  state            :string(255)
#  error_code       :string(255)
#  payment_sequence :string(255)
#  payment_infos    :text
#  log              :text
#

require 'test_helper'

class SaleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
