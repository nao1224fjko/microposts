class Micropost < ActiveRecord::Base
    #投稿はそのユーザーに属する
  belongs_to :user

  #ユーザーidが存在するバリデーション
  validates :user_id, presence: true
  #コンテンツが存在し、文字数は140までのバリデーション
  validates :content, presence: true, length: { maximum: 140 }
  
  # お気に入りは複数持てて削除可能
  # お気に入りのあるユーザーをfavoriteを経由して取得する
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  
  # このユーザにお気に入りが含まれていないかチェック
  # favorite_usersは上部記載のhas_many: XXXの部分
  def favorite?(user)
    favorite_users.include?(user)
  end
    
end
