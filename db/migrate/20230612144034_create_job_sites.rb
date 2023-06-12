class CreateJobSites < ActiveRecord::Migration[7.0]
  def change
    create_table :job_sites do |t|
      t.string :name
      t.string :url
      t.text :description
      t.string :company

      t.timestamps
    end
  end
end