class User < ApplicationRecord

before_validation :full_adress_sign_up
# 住所登録用


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

# // app/models/user.rb に追記
include JpPrefecture
jp_prefecture :prefecture_code  
# // prefecture_codeはuserが持っているカラム


# // postal_codeからprefecture_nameに変換するメソッドを用意します．
def prefecture_name
  JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
end

def prefecture_name=(prefecture_name)
  self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
end

# ここにアドレスを足算させる user.full_adressで呼び出せる
def full_address
  prefecture_code + city + building
end

# 地図表示用一旦Cityのみ、後から三つ
geocoded_by :prefecture_code
after_validation :geocode

  attachment :profile_image
  # , destroy: false　怪しいから削除　あるよなぁ

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # チャット用
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy

  # ====================自分がフォローしているユーザーとの関連 ===================================
  #フォローする側のUserから見て、フォローされる側のUserを(中間テーブルを介して)集める。なので親はfollowing_id(フォローする側)
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  # 中間テーブルを介して「follower」モデルのUser(フォローされた側)を集めることを「followings」と定義
  has_many :followings, through: :active_relationships, source: :follower
  # ========================================================================================

  # ====================自分がフォローされるユーザーとの関連 ===================================
  #フォローされる側のUserから見て、フォローしてくる側のUserを(中間テーブルを介して)集める。なので親はfollower_id(フォローされる側)
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  # 中間テーブルを介して「following」モデルのUser(フォローする側)を集めることを「followers」と定義
  has_many :followers, through: :passive_relationships, source: :following
  # =======================================================================================

  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)がフォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(following_id: user.id).present?
  end

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50 }

  private
  def full_adress_sign_up
    self.full_address = prefecture_code + city + building
  end

end
