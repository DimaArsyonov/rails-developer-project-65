class AddNullConstraintsToBulletins < ActiveRecord::Migration[7.2]
  def change
    change_column_null :bulletins, :title, false
    change_column_null :bulletins, :description, false
  end
end
