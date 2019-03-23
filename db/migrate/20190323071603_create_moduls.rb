class CreateModuls < ActiveRecord::Migration[5.2]
  def change
    create_table :moduls do |t|
      t.string :title

      t.timestamps
    end
  end
end
