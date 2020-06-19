require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "foobar",             user_name: "foo",
                 password: "foobar", password_confirmation: "foobar",
                      uid: "279139382",              email: "foo@bar.com")
  end

  test "should be valid" do
    assert @user.valid?
    assert @user.errors.empty?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "user_name should be present" do
    @user.user_name = "   "
    assert_not @user.valid?
  end

  test "user_name should not be too long" do
    @user.user_name = "a" * 51
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = "   "
    assert_not @user.valid?
  end

  test "password should not be too short" do
    @user.password = @user.password_confirmation = "   "
    assert_not @user.valid?
  end

  test "password should be equal to password_confirmation" do
    @user.password_confirmation = "a" * 6
    assert_not @user.valid?
  end

  test "uid should be present" do
    @user.uid = "  "
    assert_not @user.valid?
  end

  test "uid should be unique" do
    same_uid_user = User.new(name: "hogehoge", user_name: "hoge",
                         password: "password",       uid:  @user.uid)
    assert same_uid_user.save
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "email should be unique" do
    same_email_user = User.new(name: "hogehoge", user_name: "hoge",
                           password: "password", uid:       "123435",
                              email:"foo@bar.com")
    assert same_email_user.save
    assert_not @user.valid?
  end

  test "email allow to be nil" do
    @user.email = ""
    assert @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 139 + "@example.com"
    assert_not @user.valid?
  end

end
