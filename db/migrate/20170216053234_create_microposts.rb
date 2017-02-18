class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
      #ユーザーと投稿の関連付け
      t.index [:user_id, :created_at]
    end
  end
end
