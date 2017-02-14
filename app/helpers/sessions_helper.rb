module SessionsHelper

    #カレントユーザーが空の場合はユーザーを入れるヘルパー
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    #カレントユーザーの存在を確かめるヘルパー
    def logged_in?
        !!current_user
    end
    
    #ログインが必要なページにユーザーがアクセスした場合、ログイン画面を表示してログイン後、元のユーザーがアクセスしたかったページに飛ばすヘルパー
    def store_location
        session[:forwarding_url] = request.url if request.get?
    end
end