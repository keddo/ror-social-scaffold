class FriendshipsController < ApplicationController
    def index
      @friendship = Friendship.all
    end

    def create
      @friendship = Friendship.new(friend_params)
      return if !@friendship.save 
      redirect_to friendships_path
    end

    private 
    def friend_params
      params.permit(:user_id, :friend_id)
    end
end
