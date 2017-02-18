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
    
    
end
