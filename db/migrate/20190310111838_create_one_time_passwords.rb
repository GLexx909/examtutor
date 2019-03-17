class CreateOneTimePasswords < ActiveRecord::Migration[5.2]
  def change
    create_table :one_time_passwords do |t|
      t.string :pass_word

      t.timestamps
    end
  end
end
