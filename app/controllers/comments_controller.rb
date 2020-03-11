class CommentsController < ApplicationController

    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id 
        @comment.book_id = params[:book_id]
        if @comment.save
            redirect_back(fallback_location: root_path)
        else
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
        @comment = Comment.find_by(id: params[:id],book_id: params[:book_id],user_id: current_user.id)
        @comment.destroy
        # @comment = Comment.find_by(user_id: current_user.id,book_id: params[:book_id])
        redirect_back(fallback_location: root_path)
    end
    private
        def comment_params
            params.require(:comment).permit(:content)
        end
end
