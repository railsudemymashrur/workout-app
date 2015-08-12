class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    friend = User.find(params[:friend_id])
    Friendship.create(friendship_params.merge!(friend_id: params[:friend_id], 
      user_id: current_user.id)) unless current_user.follows_or_same?(friend)
    redirect_to root_path
  end
  
  def show
    @friend = Friendship.find(params[:id]).friend
    @exercises = @friend.exercises.all
  end
  
  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship.destroy
      flash[:success] = "#{@friendship.friend.full_name} unfollowed"
    else
      flash[:danger] = "#{@friendship.friend.full_name} could not be unfollowed"
    end
    redirect_to user_exercises_path(current_user)
  end
  
  private 
  
  def friendship_params
    params.permit(:friend_id, :user_id)
  end
end