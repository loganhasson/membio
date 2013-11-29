class AddDefaultConfirmedFalseToUser < ActiveRecord::Migration
  def up
    change_column :users, :confirmed, :boolean, :default => false
  end

  def down
    change_column :users, :confirmed, :boolean, :default => nil
  end
end
