class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :title
      t.integer :object
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
