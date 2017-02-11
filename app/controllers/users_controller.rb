class UsersController < ApplicationController

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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
