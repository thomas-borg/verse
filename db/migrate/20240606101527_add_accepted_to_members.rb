class AddAcceptedToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :accepted, :boolean, default: false
  end
end
