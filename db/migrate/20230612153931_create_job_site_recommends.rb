class CreateJobSiteRecommends < ActiveRecord::Migration[7.0]
  def change
    create_table :job_site_recommends do |t|
      t.references :user, null: true, foreign_key: true
      t.references :job_site, null: false, foreign_key: true
      t.boolean :recommended

      t.timestamps
    end
  end
end
