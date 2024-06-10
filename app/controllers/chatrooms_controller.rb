class ChatroomsController < ApplicationController

  def index
    if user_signed_in?
      @activities = Activity.where(user: current_user)
      @upcomings = Member.where(user: current_user, accepted: true)
    end
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

end
