class Profile < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :job_title_tags
end
