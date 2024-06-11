class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    activity = Activity.find(params[:id])


    stream_for activity
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
