class CreateAssignmentComments < ActiveRecord::Migration
  def change
    create_table :assignment_comments do |t|
      t.string :comment
      t.references :assignment
      t.references :security_user

      t.timestamps
    end
    add_index :assignment_comments, :assignment_id
    add_index :assignment_comments, :security_user_id
  end
end
