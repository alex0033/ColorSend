require 'test_helper'
include Warden::Test::Helpers

class LikeTest < ActiveSupport::TestCase

  def setup
    micropost = set_micropost(users(:one))
    @like = Like.new(user: users(:two), micropost: micropost)
  end

  test "user sholud not nil" do
    @like.user = nil
    assert_not @like.valid?
  end

  test "micropost sholud not nil" do
    @like.micropost = nil
    assert_not @like.valid?
  end

  test "sholud be unique" do
    duplicate_like = Like.new(user: @like.user, micropost: @like.micropost)
    assert duplicate_like.save
    assert_not @like.valid?
  end

end
