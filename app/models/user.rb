class User < ActiveRecord::Base
    #データの保存前にメールアドレスのアルファベットを小文字にします
    before_save { self.email = self.email.downcase }
    #nameはからでなく、最大30文字まで
    validates :name, presence: true, length: { maximum: 50 }
    #メールアドレスの正規表記パターンを定義
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                format: { with: VALID_EMAIL_REGEX },
                uniqueness: { case_sensitive: false }
    has_secure_password
end
