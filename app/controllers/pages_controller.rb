class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    if user_signed_in?
      @user = current_user
      @activities = Activity.where(user: @user)
      @upcomings = Member.where(user: @user, accepted: true)
      @requests = Member.where(user: @user, accepted: false)
    else
      redirect_to new_user_session_path, alert: "Vous devez être connecté pour accéder à cette page."
    end
  end

  def profile
    if user_signed_in?
      @user = current_user
      @activities = Activity.where(user: @user)
    else
      redirect_to new_user_session_path, alert: "Vous devez être connecté pour accéder à cette page."
    end
  end
end
