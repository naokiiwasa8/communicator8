require "test_helper"

class JobSitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_site = job_sites(:one)
  end

  test "should get index" do
    get job_sites_url
    assert_response :success
  end

  test "should get new" do
    get new_job_site_url
    assert_response :success
  end

  test "should create job_site" do
    assert_difference("JobSite.count") do
      post job_sites_url, params: { job_site: { description: @job_site.description, name: @job_site.name, url: @job_site.url } }
    end

    assert_redirected_to job_site_url(JobSite.last)
  end

  test "should show job_site" do
    get job_site_url(@job_site)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_site_url(@job_site)
    assert_response :success
  end

  test "should update job_site" do
    patch job_site_url(@job_site), params: { job_site: { description: @job_site.description, name: @job_site.name, url: @job_site.url } }
    assert_redirected_to job_site_url(@job_site)
  end

  test "should destroy job_site" do
    assert_difference("JobSite.count", -1) do
      delete job_site_url(@job_site)
    end

    assert_redirected_to job_sites_url
  end
end
