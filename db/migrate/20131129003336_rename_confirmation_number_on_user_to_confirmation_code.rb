class RenameConfirmationNumberOnUserToConfirmationCode < ActiveRecord::Migration
  def up
    rename_column :users, :confirmation_number, :confirmation_code
  end

  def down
    rename_column :users, :confirmation_code, :confirmation_number
  end
end
