class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.string :title
      t.boolean :complete

      t.timestamps
    end
  end
end
