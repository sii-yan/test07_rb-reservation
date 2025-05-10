class AddDetailsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string, null: false, default: ""  #deviseをカスタム:名前追加
    add_column :users, :profile_image, :string  #deviseをカスタム:プロフィール画像追加
    add_column :users, :bio, :text  #deviseをカスタム:自己紹介追加
  end
end
