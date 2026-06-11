class ChangeDefaultAdminToUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :admin, from: true, to: false
  end
end
