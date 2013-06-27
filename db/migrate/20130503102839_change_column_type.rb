class ChangeColumnType < ActiveRecord::Migration
  def change
    rename_column :webinars, :type, :access_type
  end
end
