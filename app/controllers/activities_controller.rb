class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @activities = Activity.all
    if params[:query].present?
      @activities = Activity.search_by_name_and_description(params[:query])
    end

    @markers = @activities.geocoded.map do |activity|
      {
        lat: activity.latitude,
        lng: activity.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {activity: activity}),
        marker_html: render_to_string(partial: "marker", locals: {activity: activity})
      }
    end
  end

  def new
    @activity = Activity.new
    @sports = Sport.all
  end

  def create
    # raise
    @activity = Activity.new(activity_params)
    @activity.user = current_user
    # @activity.sport_id = Sport.find(params[:sport])
    if @activity.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @activity = Activity.find(params[:id])
    @is_member = Member.where(user: current_user, activity: params[:id])
    if current_user
      @member = Member.new
    end
    @markers = [{
      lat: @activity.latitude,
      lng: @activity.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { activity: @activity }),
      marker_html: render_to_string(partial: "marker", locals: { activity: @activity })
    }]
  end


  def edit
  end

  def update
    if @activity.update(activity_params)
      redirect_to activity_path(@activity)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    redirect_to dashboard_path
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:name, :date_time, :description, :location, :sport_id, :user_id)
  end
end
