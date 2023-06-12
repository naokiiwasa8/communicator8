class JobSite < ApplicationRecord
  has_many :job_site_recommends
  has_many :users, through: :job_site_recommends

  def recommended_count
    job_site_recommends.where(recommended: true).count
  end

  def not_recommended_count
    job_site_recommends.where(recommended: false).count
  end
end
