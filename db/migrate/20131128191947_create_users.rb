class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :phone_number
      t.integer :confirmation_number

      t.timestamps
    end
  end
end
