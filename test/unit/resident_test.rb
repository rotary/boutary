# == Schema Information
#
# Table name: residents
#
#  id                   :integer          not null, primary key
#  sale_id              :integer          not null
#  last_name            :string(255)      not null
#  first_name           :string(255)      not null
#  birth_on             :date
#  club                 :string(255)
#  address              :text
#  phone                :string(255)
#  email                :string(255)
#  identity_number      :string(255)
#  identity_valid_until :date
#

require 'test_helper'

class ResidentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
