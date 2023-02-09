class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id]) #book_idの一致するものを取得
    comment = current_user.book_comments.new(book_comment_params) #ログインユーザーの情報が入ったコメントを新規作成（ストロングパラメーターあり）
    comment.book_id = book.id #commentのbook_idに取得したidを代入
    comment.save #コメントを保存
    redirect_to request.referer  #遷移元のURLを取得してリダイレクト
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy #idとbook_id両方が一致するコメントを取得して削除
    redirect_to request.referer #遷移元のURLを取得してリダイレクト
  end

  private #フロントエンドからアクセス出来ないようにする

  def book_comment_params #ストロングパラメーター
    params.require(:book_comment).permit(:comment) #book_commentオブジェクトのcommentキーにのみ保存可能にする
  end
end
