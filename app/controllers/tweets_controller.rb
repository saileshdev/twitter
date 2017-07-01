class TweetsController < ApplicationController

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id

    flash[:error] = "Your Tweet was over 140 characters" unless tweet.save
    redirect_to root_url 
       
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end

end
