class AddOauthImageToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :oauth_image, :string
  end
end
