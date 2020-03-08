class Room < ApplicationRecord
  # チャットルームの定義
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
end
