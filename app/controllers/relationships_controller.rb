class RelationshipsController < ApplicationController

  def create
    relationship = Relationship.new(relationship_params)
    relationship.follower = current_user
    # The above is same as @relationship.follower_id = current_user.id 

    flash[:error] = "Couldn't follow" unless relationship.save
    redirect_to relationship.followed
  end

  def destroy
  	relationship = Relationship.find(params[:id])
  	user = relationship.followed
  	relationship.destroy
  	redirect_to user
  end

private

  def relationship_params
    params.require(:relationship).permit(:followed_id)
  end

end
