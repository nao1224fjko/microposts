class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :followings, :followers]
  before_action :check_user, only: [:edit, :update]
  
  def show # ユーザーページ
    # before_action :set_userでユーザーをセットしているので下記一文は省ける
    # @user  = User.find(params[:id])
   # マイクロポストを作成日時の新しいものから順に@micropostsに代入する
   @microposts = @user.microposts.order(created_at: :desc)
   # ページングkaminariの代入 
   @microposts = current_user.microposts.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  
  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"#フラッシュメッセージ
      redirect_to @user #新規登録後ユーザーページにリダイレクト
    else
      render 'new'
    end
  end
  
  def edit
    # before_action :set_userでユーザーをセットしているので下記一文は省ける
    # @user  = User.find(params[:id])
  end
  

  def update
    # before_action :set_userでユーザーをセットしているので下記一文は省ける
    # @user  = User.find(params[:id])
    if @user.update(user_params)
      #プロフィールの保存に成功した場合
      flash[:success] = "プロフィールを編集しました"#フラッシュメッセージ
      redirect_to @user #ユーザーページにリダイレクト
    else
    # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  #フォロー中一覧
  def followings
    # before_action :set_userでユーザーをセットしているので下記一文は省ける
    # @user  = User.find(params[:id])
    @users = @user.following_users
  end
  
  #フォロワー一覧
  def followers
    # before_action :set_userでユーザーをセットしているので下記一文は省ける
    # @user  = User.find(params[:id])
    @users = @user.follower_users
  end






  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :nickname, :birthday)
  end
  
  
  def set_user
    @user = User.find(params[:id])
  end
  
  
  def check_user
    #アクセスした先のユーザーとログインしているユーザーが一致しない場合
    unless current_user == @user
      redirect_to root_url #トップページにリダイレクト
    end
  end
  
end