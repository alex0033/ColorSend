require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "foobar", user_name: "foo", password: "foobar", password_confirmation: "foobar", uid: "279139382")
  end

  test "should be valid" do
    assert @user.valid?
    assert @user.errors.empty?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
    assert_not @user.errors.empty?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
    assert_not @user.errors.empty?
  end

  test "user_name should be present" do
    @user.user_name = "   "
    assert_not @user.valid?
    assert_not @user.errors.empty?
  end

  test "user_name should not be too long" do
    @user.user_name = "a" * 51
    assert_not @user.valid?
    assert_not @user.errors.empty?
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = "   "
    assert_not @user.valid?
    assert_not @user.errors.empty?
  end

  test "password should not be too short" do
    @user.password = @user.password_confirmation = "   "
    assert_not @user.valid?
    assert_not @user.errors.empty?
  end

  test "password should be equal to password_confirmation" do
    @user.password_confirmation = "a" * 6
    assert_not @user.valid?
    assert_not @user.errors.empty?
  end

  test "uid should be present" do
    @user.uid = "  "
    assert_not @user.valid?
    assert_not @user.errors.empty?
  end

  test "uid should be unique" do
    same_uid_user = User.new(name: "hogehoge", user_name: "hoge", password: "password", uid: @user.uid)
    assert same_uid_user.save
    assert_not @user.valid?
    assert_not @user.errors.empty?
    # error_messagesの称号も書く
  end

end
