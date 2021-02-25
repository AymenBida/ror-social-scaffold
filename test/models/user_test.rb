require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save user without params" do
    user = User.new
    assert_not user.save
  end
end