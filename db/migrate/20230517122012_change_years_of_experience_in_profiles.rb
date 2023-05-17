class ChangeYearsOfExperienceInProfiles < ActiveRecord::Migration[7.0]
  def change
    change_column :profiles, :years_of_experience, :string
  end
end
