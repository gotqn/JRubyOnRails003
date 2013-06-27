class CreateWebinars < ActiveRecord::Migration
  def change
    create_table :webinars do |t|
      t.string :name
      t.string :type
      t.datetime :upload_date
      t.boolean :is_active
      t.string :summary

      t.timestamps
    end
  end
end
