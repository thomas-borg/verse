class MembersController < ApplicationController

  def create
    @activity = Activity.find(params[:activity_id])
    @member = Member.new
    @member.activity = @activity
    @member.accepted = false

    @member.user = current_user

    if @member.save!
      flash[:notice] = "Request sent!"
      redirect_to dashboard_path
    end
  end

  def update
    @member = Member.find(params[:id])
    @member.accepted = true
    @member.save

    flash[:notice] = "Member accepted!"
    redirect_to dashboard_path
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy

  flash[:alert] = "Request denied!"
    redirect_to dashboard_path
  end

end
