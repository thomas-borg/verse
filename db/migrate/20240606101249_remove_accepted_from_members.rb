class RemoveAcceptedFromMembers < ActiveRecord::Migration[7.1]
  def change
    remove_column :members, :accepted, :boolean
  end
end
