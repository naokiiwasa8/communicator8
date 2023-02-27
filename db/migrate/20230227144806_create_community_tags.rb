class CreateCommunityTags < ActiveRecord::Migration[7.0]
  def change
    create_table :community_tags do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :community, null: false, foreign_key: true
      t.timestamps
    end
  end
end
