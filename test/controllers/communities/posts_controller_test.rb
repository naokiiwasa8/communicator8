require "test_helper"

class Communities::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @communities_post = communities_posts(:one)
  end

  test "should get index" do
    get communities_posts_url
    assert_response :success
  end

  test "should get new" do
    get new_communities_post_url
    assert_response :success
  end

  test "should create communities_post" do
    assert_difference("Communities::Post.count") do
      post communities_posts_url, params: { communities_post: {  } }
    end

    assert_redirected_to communities_post_url(Communities::Post.last)
  end

  test "should show communities_post" do
    get communities_post_url(@communities_post)
    assert_response :success
  end

  test "should get edit" do
    get edit_communities_post_url(@communities_post)
    assert_response :success
  end

  test "should update communities_post" do
    patch communities_post_url(@communities_post), params: { communities_post: {  } }
    assert_redirected_to communities_post_url(@communities_post)
  end

  test "should destroy communities_post" do
    assert_difference("Communities::Post.count", -1) do
      delete communities_post_url(@communities_post)
    end

    assert_redirected_to communities_posts_url
  end
end
