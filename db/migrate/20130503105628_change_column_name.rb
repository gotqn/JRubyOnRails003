class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :webinars, :summary_notes, :summary
  end
end
