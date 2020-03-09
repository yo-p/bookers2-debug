class FavoritesController < ApplicationController
    
    def create
        @book = Book.find(params[:id])
        @book.like(current_user)
        redirect_to book_path(@book)
    end

    def destroy
        @book = like.find(params[:id]).book.
        @book.unlike(current_user)
        redirect_to book_path(@book)
    end
end