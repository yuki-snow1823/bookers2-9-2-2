class UserRoom < ApplicationRecord
  # チャットルームとユーザーの関連の定義
  belongs_to :user
  belongs_to :room
end
