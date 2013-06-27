class ChangeColumnTypeSummary < ActiveRecord::Migration
  def change
    rename_column :webinars, :summary, :summary_notes
  end
end
