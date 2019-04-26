class CreateWeeklyDigests < ActiveRecord::Migration[5.2]
  def change
    create_table :weekly_digests do |t|
      t.references :user, foreign_key: true, unique: true
      t.string :email, null: false

      t.timestamps
    end
  end
end
