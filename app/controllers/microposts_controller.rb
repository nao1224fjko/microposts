class MicropostsController < ApplicationController
    #ログインしたユーザーのみ投稿をクリエイト・デストロイできる
    before_action :logged_in_user, only: [:create, :destroy]
    
      def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
          flash[:success] = "Micropost created!"
          redirect_to root_url
        else
          #エラーが発生した場合はstatic_pages/homeテンプレートを使用する
          @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
          #エラーが発生した場合もページング機能を使用する
          @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
          render 'static_pages/home'
        end
      end
      
      
      def destroy
        @micropost = current_user.microposts.find_by(id: params[:id])
        return redirect_to root_url if @micropost.nil?
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        redirect_to request.referrer || root_url
      end



    private
    #ストロングパラメータで受け取るデータを制限。不要なデータは受け取らない
    def micropost_params
        params.require(:micropost).permit(:content)
    end

end
