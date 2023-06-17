class JobSiteRecommendsController < JobSitesController
  before_action :set_job_site
  before_action :set_job_sites_page
  before_action :check_auth
  before_action :check_max_recommends, only: [:recommend]
  before_action :check_max_not_recommends, only: [:not_recommend]

  def recommend
    @job_site.job_site_recommends.create!(user: current_user, recommended: true)
    flash.now.notice = "#{@job_site.name}を推奨しました"
    render 'job_sites/result'
  end

  def not_recommend
    @job_site.job_site_recommends.create!(user: current_user, recommended: false)
    flash.now.notice = "#{@job_site.name}を非推奨しました"
    render 'job_sites/result'
  end

  private

  def check_auth
    unless current_user
      flash.now.notice = "ログイン後に推奨・非推奨ができます"
      render 'job_sites/result'
      return
    end
  end

  def check_max_recommends
    if current_user.max_recommends_reached?
      flash.now.alert = '1日の推奨回数の上限(5回)に達しました'
      render 'job_sites/result'
    end
  end
  
  def check_max_not_recommends
    if current_user.max_not_recommends_reached?
      flash.now.alert = '1日の非推奨回数の上限(5回)に達しました'
      render 'job_sites/result'
    end
  end
end
