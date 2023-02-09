class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id]) #指定のbook_idのブックを取得
    favorite = current_user.favorites.new(book_id: book.id) #ログイン中のユーザーのfavを新規作成。book_idには取得したブックのidを入れる。
    favorite.save #保存
    redirect_to request.referer #遷移元のURLを取得してリダイレクト
  end

  def destroy
    book = Book.find(params[:book_id]) #指定のbook_idのブックを取得
    favorite = current_user.favorites.find_by(book_id: book.id) #ログイン中のユーザーのfavを検索。book_idには取得したブックのidを入れる。
    favorite.destroy #削除
    redirect_to request.referer #遷移元のURLを取得してリダイレクト
  end
end
