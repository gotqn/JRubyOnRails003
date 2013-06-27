class AddAttachmentVideoToWebinars < ActiveRecord::Migration
  def self.up
    change_table :webinars do |t|
      t.attachment :video
    end
  end

  def self.down
    drop_attached_file :webinars, :video
  end
end
