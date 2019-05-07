class AddDataToAttendances < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :date, :datetime
  end
end
