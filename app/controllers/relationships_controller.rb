class RelationshipsController < ApplicationController

  before_action :authenticate_user! #ユーザがログインしているかどうかを確認し、ログインしていない場合はユーザをログインページにリダイレクトする。

  def create
    user = User.find(params[:user_id]) #Userモデルからuser_idが一致するものを見つけてuserに代入
    current_user.follow(user) #ログイン中のユーザー情報とフォローするユーザーのidを関連付けてrelationshipモデルにクリエイト
		redirect_to request.referer #遷移元のURLを取得してリダイレクト
  end

  def destroy
    user = User.find(params[:user_id]) #Userモデルからuser_idが一致するものを見つけてuserに代入
    current_user.unfollow(user) #ログイン中のユーザー情報とフォローするユーザーのidが関連付いているデータを探して削除
		redirect_to request.referer #遷移元のURLを取得してリダイレクト
  end

  def followings
    user = User.find(params[:user_id]) #Userモデルからuser_idが一致するものを見つけてuserに代入
		@users = user.followings #userのフォローしている人一覧を@usersに代入
  end

  def followers
    user = User.find(params[:user_id]) #Userモデルからuser_idが一致するものを見つけてuserに代入
		@users = user.followers #userのフォローされている人一覧を@usersに代入
  end
end
