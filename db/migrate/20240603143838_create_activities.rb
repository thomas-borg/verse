class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sport, null: false, foreign_key: true
      t.text :description
      t.date :date_time
      t.string :location
      t.string :name
      t.integer :group_size

      t.timestamps
    end
  end
end
