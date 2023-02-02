class Community < ApplicationRecord

  ## Validations
  with_options presence: true do
    validates :community_name
  end
end
