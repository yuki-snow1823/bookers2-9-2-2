class Chat < ApplicationRecord
  # チャットの定義
  belongs_to :user
  belongs_to :room
end
