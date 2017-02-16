class Micropost < ActiveRecord::Base
    #投稿はそのユーザーに属する
  belongs_to :user

  #ユーザーidが存在するバリデーション
  validates :user_id, presence: true
  #コンテンツが存在し、文字数は140までのバリデーション
  validates :content, presence: true, length: { maximum: 140 }
  
  #ユーザーは複数の投稿（マイクロポスト）を持つことができる
  has_many :microposts

end
