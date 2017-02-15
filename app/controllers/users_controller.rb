class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :check_user, only: [:edit, :update]
  
  def show # ユーザーページ
   @user = User.find(params[:id])
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
  end
  
  
  def update
    if @user.update(user_params)
      #プロフィールの保存に成功した場合
      flash[:success] = "プロフィールを編集しました"#フラッシュメッセージ
      redirect_to @user #ユーザーページにリダイレクト
    else
    # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
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
