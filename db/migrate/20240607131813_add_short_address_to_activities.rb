class AddShortAddressToActivities < ActiveRecord::Migration[7.1]
  def change
    add_column :activities, :short_address, :text
  end
end
