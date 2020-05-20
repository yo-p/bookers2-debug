class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :user_id, null: false
      t.integer :book_id, null: false

      t.timestamps

      t.index :user_id
      t.index :book_id 
      t.index [:user_id,:book_id], unique: true #一人のユーザーが同じ投稿に複数いいねをさせないunique

    end
  end
end
