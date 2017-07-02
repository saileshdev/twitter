class UsersController < ApplicationController

def new
	if current_user
		redirect_to buddies_path
	else
		@user = User.new
	end
end

def create
	@user = User.new(user_params)
	if @user.save
		session[:user_id] = @user.id
		redirect_to @user, notice: "Thank you for signing up for Twitter!"
	else
		render 'new'
	end
end

def show
	@user = User.find(params[:id])
	@tweet = Tweet.new
	@relationship = Relationship.where(
	  follower_id: current_user.id,
      followed_id: @user.id
    ).first_or_initialize if current_user
end

def index
	@users = User.all
	@tweet = Tweet.new
end

def buddies
    if current_user
      @tweet = Tweet.new
      buddies_ids = current_user.followeds.map(&:id).push(current_user.id)
      @tweets = Tweet.where(user_id: buddies_ids)
    else
      redirect_to root_url
    end
  end

def edit
	@user = User.find(params[:id])
end

def update
	@user = User.find(params[:id])

	if @user.update_attributes(user_params)
		redirect_to @user, notice: "Profile updated!"
	else
		render 'edit'
	end
end

private

def user_params
  params.require(:user).permit(:email, :name, :username, :password, 
  	:password_confirmation, :bio)
end

end
