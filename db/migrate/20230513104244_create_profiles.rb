class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.text :biography
      t.date :birthday
      t.string :job_title
      t.string :company
      t.integer :years_of_experience
      t.string :github_url
      t.string :twitter_url
      t.string :facebook_url
      t.string :instagram_url
      t.string :tiktok_url
      t.string :qiita_url
      t.string :note_url
      t.string :teratail_url
      t.string :connpass_url
      t.string :speaker_deck_url
      t.string :doorkeeper_url
      t.string :zenn_url

      t.timestamps
    end
  end
end
