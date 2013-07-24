class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :subject
      t.string :technologies
      t.string :description
      t.string :status
      t.string :type
      t.boolean :is_disabled

      t.timestamps
    end
  end
end
