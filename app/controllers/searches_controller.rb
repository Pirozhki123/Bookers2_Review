class SearchesController < ApplicationController
  before_action :authenticate_user! #ユーザがログインしているかどうかを確認し、ログインしていない場合はユーザをログインページにリダイレクトする。

	def search
		@model = params[:model] #User検索かBook検索かの選択を代入
		@content = params[:content] #検索ワードを代入
		@method = params[:method] #検索条件を代入
		if @model == 'user' #ユーザー検索の場合
			@records = User.search_for(@content, @method) #ユーザー検索の結果を代入（Userモデルで定義したsearch_forメソッドを使用）
		else #それ以外の場合
			@records = Book.search_for(@content, @method) #ブック検索の結果を代入（Bookモデルで定義したsearch_forメソッドを使用）
		end
	end
end
