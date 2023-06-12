class JobSiteRecommendsController < ApplicationController
  before_action :set_job_site

  def recommend
    @job_site.job_site_recommends.create!(user: current_user, recommended: true)
    redirect_to job_sites_path
  end

  def not_recommend
    @job_site.job_site_recommends.create!(user: current_user, recommended: false)
    redirect_to job_sites_path
  end

  private

  def set_job_site
    @job_site = JobSite.find(params[:id])
  end
end
