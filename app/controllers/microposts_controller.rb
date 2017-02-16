class MicropostsController < ApplicationController
    #ログインしたユーザーのみ投稿をクリエイトできる
    before_action :logged_in_user, only: [:create]
    
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Microposts created!"
            redirect_to root_url
        else
            render 'static_pages/home'
        end
    end
    
    private
    #ストロングパラメータで受け取るデータを制限。不要なデータは受け取らない
    def micropost_params
        params.require(:micropost).permit(:content)
    end

end
