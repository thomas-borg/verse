class MembersController < ApplicationController

  def create
    @activity = Activity.find(params[:activity_id])
    @member = Member.new
    @member.activity = @activity
    @member.user = current_user

    if @member.save!
      redirect_to dashboard_path
    end

  end
end
