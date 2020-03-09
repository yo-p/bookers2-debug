class Book < ApplicationRecord
	belongs_to :user, optional: true
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。

	has_many :favorites, dependent: :destroy #bookは複数のいいねをもつ

	#has_many :liked_users, through: :likes, source: :user

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	#bookをいいねする
	def like(user)
		favorite.create(user_id: user.id)
	end

	def unlike(user)
		favorite.find_by(user_id: user.id).destroy
	end
end
