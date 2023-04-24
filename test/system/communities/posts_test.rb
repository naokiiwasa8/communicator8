require "application_system_test_case"

class Communities::PostsTest < ApplicationSystemTestCase
  setup do
    @communities_post = communities_posts(:one)
  end

  test "visiting the index" do
    visit communities_posts_url
    assert_selector "h1", text: "Posts"
  end

  test "should create post" do
    visit communities_posts_url
    click_on "New post"

    click_on "Create Post"

    assert_text "Post was successfully created"
    click_on "Back"
  end

  test "should update Post" do
    visit communities_post_url(@communities_post)
    click_on "Edit this post", match: :first

    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end

  test "should destroy Post" do
    visit communities_post_url(@communities_post)
    click_on "Destroy this post", match: :first

    assert_text "Post was successfully destroyed"
  end
end
