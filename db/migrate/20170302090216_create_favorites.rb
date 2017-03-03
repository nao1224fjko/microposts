class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user, index: true
      t.references :micropost, index: true
      t.timestamps null: false
      
      t.index [:user_id, :micropost_id], unique: true #この行を追加
    end
  end
end
