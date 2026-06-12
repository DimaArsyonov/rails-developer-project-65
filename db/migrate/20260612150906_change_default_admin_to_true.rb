class ChangeDefaultAdminToTrue < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :admin, from: false, to: true
  end
end
