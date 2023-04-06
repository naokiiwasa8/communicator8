class CreateFavoriteCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :favorite_communities do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :community, null: false, foreign_key: true
      t.timestamps
    end
  end
end
