class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string :attachable_type, :limit => 30
      t.integer :attachable_id
      t.string :file_name, :limit => 100
      t.string :content_type, :limit => 50
      t.integer :file_size
      t.binary :data, :limit => 1024

      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
