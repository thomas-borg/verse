class ChangeDateTimeToDateAndTimeInActivities < ActiveRecord::Migration[7.1]
  def change
    change_column :activities, :date_time, :datetime
  end
end
