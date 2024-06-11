class MessagesController < ApplicationController

  def index
    @activity = Activity.find(params[:activity_id])
    @messages = Message.where(activity: @activity)
    @message = Message.new
  end

  def create
    @activity = Activity.find(params[:activity_id])
    @message = Message.new(message_params)
    @message.activity = @activity
    @message.user = current_user
    if @message.save
      ChatroomChannel.broadcast_to(
        @activity,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok
    else
      render "activities/show", status: :unprocessable_entity
    end

  end

  private

  def message_params
    params.require(:message).permit(:content, :activity_id)
  end

end
