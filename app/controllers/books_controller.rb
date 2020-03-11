class BooksController < ApplicationController

  def show
	@new_book = Book.new
	  @book = Book.find(params[:id])
	  @user = @book.user
	  @favorite = Favorite.new
	  @comment = Comment.new
	  @comments = @book.comments
  end

  def index
	@books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
	@book = Book.new
	@user = current_user
	@favorite = Favorite.new
	  
  end

  def create
	  @book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
	  @book.user_id = current_user.id
  	if @book.save #入力されたデータをdbに保存する。
		flash[:notice] = "successfully created book!"#保存された場合の移動先を指定。
		redirect_to book_path(@book) 
	  else
		# @book = Book.new
		@user = current_user
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
	@book = Book.find(params[:id])
	@user = current_user
	  if @book.user_id != current_user.id
		redirect_to books_path
	  end
  end



  def update
  	@book = Book.find(params[:id])
	  if @book.update(book_params)
		flash[:notice] = "successfully updated book!"
  		redirect_to book_path
	  else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
		@user = current_user
  		render "edit"
  	end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title,:body)
  end

end
