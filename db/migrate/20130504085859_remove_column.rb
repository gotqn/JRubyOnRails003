class RemoveColumn < ActiveRecord::Migration
  def up
    remove_column :webinars, :upload_date
  end

  def down
    add_column :webinars, :upload_date, :datetime
  end
end
