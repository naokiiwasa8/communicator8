class JobSiteRecommend < ApplicationRecord
  belongs_to :user
  belongs_to :job_site
end
