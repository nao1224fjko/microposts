class User < ActiveRecord::Base
    
    #データの保存前にメールアドレスのアルファベットを小文字にします
    before_save { self.email = self.email.downcase }
    
    #nameは空ではなく最大50文字まで
    validates :name, presence: true, length: { maximum: 50 }
    
    #メールアドレスの正規表記パターンを定義
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                format: { with: VALID_EMAIL_REGEX },
                uniqueness: { case_sensitive: false }

    has_secure_password

    #nicknameは必須ではなく最大30文字まで
    validates :nickname, length: { maximum: 30 }

    #birthdayは必須ではない
    validates :birthday, length: { maximum: 10 }
    
    
    #ユーザーは複数の投稿（マイクロポスト）を持つことができる
    has_many :microposts
    
    #ユーザーは複数のリツイートを持つことができる
    has_many :retweets

    #ユーザーは複数のリツイート（original_id）を持つことができる
    has_many :original_id
    
    
    #フォローしているユーザー
    has_many :following_relationships, class_name: "Relationship",
                            foreign_key: "follower_id",
                            dependent: :destroy
    #フォローしているユーザー一覧を受け取る                        
    has_many :following_users, through: :following_relationships, source: :followed
    
    
    #フォロアー
    has_many :follower_relationships, class_name: "Relationship",
                            foreign_key: "followed_id",
                            dependent: :destroy
    #フォロアー一覧を受け取る
    has_many :follower_users, through: :follower_relationships, source: :follower
    
    
    
    # 他のユーザーをフォローする
    def follow(other_user)
        following_relationships.find_or_create_by(followed_id: other_user.id)
    end
    
    # フォローしているユーザーをアンフォローする
    def unfollow(other_user)
        following_relationship = following_relationships.find_by(followed_id: other_user.id)
        following_relationship.destroy if following_relationship
    end
    
    
    # あるユーザーをフォローしているかどうか？
    def following?(other_user)
        following_users.include?(other_user)
    end
    
    
    #自分とフォローしているユーザーのつぶやきを取得する
    def feed_items
        Micropost.where(user_id: following_user_ids + [self.id])
    end
    
    
    
    #ユーザーは複数のお気に入りを持つことができる
    #お気に入りの一覧を取得することができる
    has_many :favorites, dependent: :destroy
    has_many :favorite_microposts, through: :favorites, source: :micropost
    
    
    
    # お気に入りに追加する
    # 現在のユーザーのfavoriteの中からお気に入りに追加するべくクリックしたmicropost_idを検索し、なかった場合新しくお気に入りを作成します。
    def favorite(micropost)
        favorites.find_or_create_by(micropost_id: micropost.id)
    end

    
    # お気に入りを削除する
    # favoriteの中から消したいmicropost_idを探し、存在する場合は削除します。
    def unfavorite(micropost)
        favorite = favorites.find_by(micropost_id: micropost.id)
        favorite.destroy if favorite
    end
    
    
end
