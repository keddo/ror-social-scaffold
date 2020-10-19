class FriendshipsController < ApplicationController
  def index
    @friendship = Friendship.all
  end

  def create
    @friendship = Friendship.new(friend_params)
    return unless @friendship.save

    redirect_to request.referrer, notice: "Request was successfully sent to #{@friendship.friend.name}"
  end

  def confirm
    @user = User.find(params[:friendship_id])
    current_user.confirm_friend(@user)
    flash[:notice] = "Congrats! You added #{@user.name} to your friend list!"
    redirect_to request.referrer
  end

  def reject
    @friendship = Friendship.find_by(user_id: params[:friendship_id])
    flash[:notice] = "You canceled #{@user.name} friend request!" if @friendship.destroy
    redirect_to request.referrer
  end

  def destroy
    @user = User.find(params[:id])
    @friendship1 = Friendship.find_by(user_id: current_user.id, friend_id: params[:id])
    @friendship2 = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)

    flash[:alert] = "You have unfriended #{@user.name}" if @friendship1.destroy && @friendship2.destroy
    redirect_to request.referrer
  end
  
  private

  def friend_params
    params.permit(:user_id, :friend_id)
  end
end
