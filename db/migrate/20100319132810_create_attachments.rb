class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string :attachable_type, :limit => 30
      t.integer :attachable_id
      t.string :attach_file_name, :limit => 100
      t.string :attach_content_type, :limit => 50
      t.integer :attach_file_size
      t.datetime :attach_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :attachs
  end
end
