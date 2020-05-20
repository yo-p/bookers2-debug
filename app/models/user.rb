# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # フォローできるユーザーを取り出す記述(user.following_relationships.followings)
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships

  # フォローされているユーザーを取り出す(user.followers)
  has_many :follower_relationshops, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationshops

  has_many :favorites, dependent: :destroy #userは複数のいいねをする

  #has_many :liked_books, through: :likes, source: :book

  has_many :books, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book

  has_many :comments, dependent: :destroy

  attachment :profile_image

  # バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: { maximum: 20, minimum: 2 }
  validates :introduction, length: { maximum: 50 }

  def already_favorited?(book)
    favorites.exists?(book_id: book.id)
  end

  # フォローする関数
  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  # フォローしているか調べるための関数
  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  # フォローを外す関数
  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end
end
