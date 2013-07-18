class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title
      t.string :description
      t.string :contacts
      t.string :instantiated_by
      t.boolean :is_proceed

      t.timestamps
    end
  end
end
