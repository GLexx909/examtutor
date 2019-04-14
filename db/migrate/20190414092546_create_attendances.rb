class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :user, foreign_key: { to_table: :users}
      t.text :description
      t.string :color

      t.timestamps
    end
  end
end
