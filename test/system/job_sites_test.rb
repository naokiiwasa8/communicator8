require "application_system_test_case"

class JobSitesTest < ApplicationSystemTestCase
  setup do
    @job_site = job_sites(:one)
  end

  test "visiting the index" do
    visit job_sites_url
    assert_selector "h1", text: "Job sites"
  end

  test "should create job site" do
    visit job_sites_url
    click_on "New job site"

    fill_in "Description", with: @job_site.description
    fill_in "Name", with: @job_site.name
    fill_in "Url", with: @job_site.url
    click_on "Create Job site"

    assert_text "Job site was successfully created"
    click_on "Back"
  end

  test "should update Job site" do
    visit job_site_url(@job_site)
    click_on "Edit this job site", match: :first

    fill_in "Description", with: @job_site.description
    fill_in "Name", with: @job_site.name
    fill_in "Url", with: @job_site.url
    click_on "Update Job site"

    assert_text "Job site was successfully updated"
    click_on "Back"
  end

  test "should destroy Job site" do
    visit job_site_url(@job_site)
    click_on "Destroy this job site", match: :first

    assert_text "Job site was successfully destroyed"
  end
end
