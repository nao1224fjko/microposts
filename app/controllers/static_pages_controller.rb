class StaticPagesController < ApplicationController
  
  def index
    @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(5)
  end
  
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
  end
  
end
