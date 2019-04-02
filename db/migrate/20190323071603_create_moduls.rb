class CreateModuls < ActiveRecord::Migration[5.2]
  def change
    create_table :moduls do |t|
      t.integer :index
      t.string :title
      t.boolean :status, default: false
      t.belongs_to :course

      t.timestamps
    end
  end
end
