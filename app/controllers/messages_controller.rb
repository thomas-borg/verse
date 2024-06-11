class MessagesController < ApplicationController

  require 'action_view'
  require 'action_view/helpers'
  include ActionView::Helpers::DateHelper
  require 'active_support/core_ext/numeric/time'


  def index
    @activity = Activity.find(params[:activity_id])
    @messages = Message.where(activity: @activity)
    @message = Message.new
  end

  def show
    @message = Message.find(params[:id])
    @sent_time = @message.created_at
  end


  def create
    @activity = Activity.find(params[:activity_id])
    @message = Message.new(message_params)
    @message.activity = @activity
    @message.user = current_user
    if @message.save
      ChatroomChannel.broadcast_to(
        @activity,
        message: render_to_string(partial: "message", locals: { message: @message }),
        sender_id: @message.user.id
      )
    else
      render "activities/show", status: :unprocessable_entity
    end

  end

  private

  def message_params
    params.require(:message).permit(:content, :activity_id)
  end



end
