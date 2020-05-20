# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :baria_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new # new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
    @users = User.all # 一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
    @user = current_user
    @book = Book.new # new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user) if @user.id != current_user.id
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'successfully updated user!'
      redirect_to user_path(@user)
      # notice: "successfully updated user!"
    else
      render 'edit'
    end
  end

  def destroy
    flash[:notice] = 'Signed out successfully'
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image)
  end

  # url直接防止メソッドを自己定義してbefore_actionで発動。
  def baria_user
    unless params[:id].to_i == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
