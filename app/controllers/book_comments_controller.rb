class BookCommentsController < ApplicationController
  before_action :authenticate_user! 
  before_action :correct_user, only: [:destroy]
  
  def create
    @book = Book.find(params[:book_id])
    @comment = BookComment.new(book_comment_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id
    @comment.save
    # redirect_back(fallback_location: root_path)　非同期のためコメントアウト
  end

  def destroy
    @book = Book.find(params[:book_id])
    # 消した後に一覧を出すために必要
    @comment = BookComment.find(params[:id])
    # @comment.user_id = current_user.id
    # これ全部消えない？やっぱり全部消える、というか他の本のコメントも消える→findparamsにして、idをしっかり送る
    @comment.destroy
    # redirect_back(fallback_location: root_path)
  end



  private
def book_comment_params
    params.require(:book_comment).permit(:comment)
end


def correct_user
  # コメントした本人＋ではないならリダイレクトさせるという表現がしたい
  @comment = BookComment.find(params[:id])

  if current_user.id != @comment.user.id
    redirect_to books_path
  # 正しいユーザーではない場合本一覧に戻す
  end
end


end
