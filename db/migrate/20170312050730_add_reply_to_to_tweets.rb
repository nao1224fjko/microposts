class AddReplyToToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :reply_to, :integer
  end
end
