require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "foobar", email: "foo@bar.com", password: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "name should be unique" do
    same_name_user = User.new( name: @user.name, email: "notfoo@bar.com", password: "foobar" )
    assert same_name_user.save
    assert_not @user.valid?
  end

end
