class CreateEssays < ActiveRecord::Migration[5.2]
  def change
    create_table :essays do |t|
      t.string :title, null: false
      t.belongs_to :modul

      t.timestamps
    end
  end
end
