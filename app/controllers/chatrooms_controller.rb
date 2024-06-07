class ChatroomsController < ApplicationController

  def index

    @chatrooms = Chatroom.where(user: current_user) if user_signed_in?

  end

  def show
    @chatroom = Chatroom.find(params[:id])
  end

end
