require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "foobar",             user_name: "foo",
                 password: "foobar", password_confirmation: "foobar",
                      uid: "279139382",              email: "foo@bar.com",
        self_introduction: "This is sample self_introduction",
                  website: "https://localhost3000",
                    image: "https://localhost3000" )
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

  test "user_name should be present" do
    @user.user_name = "   "
    assert_not @user.valid?
  end

  test "user_name should not be too long" do
    @user.user_name = "a" * 51
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = @user.password_confirmation = "            "
    assert_not @user.valid?
  end

  test "password should not be too short" do
    @user.password = @user.password_confirmation = "aaa"
    assert_not @user.valid?
  end

  test "password should be equal to password_confirmation" do
    @user.password_confirmation = "a" * 6
    assert_not @user.valid?
  end

  test "password should allow nil" do
    user = users(:one) # パスワードは空です
    assert user.valid?
  end

  test "uid should be present" do
    @user.uid = "  "
    assert_not @user.valid?
  end

  test "uid should be unique" do
    same_uid_user = User.new(name: "hogehoge", user_name: "hoge",
                         password: "password",       uid:  @user.uid,
                            image: "https://localhost:3000")
    assert same_uid_user.save
    assert_not @user.valid?
  end

  test "email should be valid format" do
    @user.email = "jfjdls .hhdjue"
    assert_not @user.valid?
  end

  test "email allow to be nil" do
    @user.email = nil
    assert @user.valid?
  end

  test "email allow to be zero-string" do
    @user.email = ""
    assert @user.valid?
  end

  test "self introduction should not be too long" do
    @user.self_introduction = "a" * 501
    assert_not @user.valid?
  end

  test "website should not be too long" do
    @user.website = "https://example.com/" + "a" * 490
    assert_not @user.valid?
  end

  test "gender should not be too long" do
    @user.gender = "a" * 51
    assert_not @user.valid?
  end

end
