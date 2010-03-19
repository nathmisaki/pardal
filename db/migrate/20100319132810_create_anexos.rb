class CreateAnexos < ActiveRecord::Migration
  def self.up
    create_table :anexos do |t|
      t.string :attachable_type, :limit => 30
      t.integer :attachable_id
      t.string :anexo_file_name, :limit => 100
      t.string :anexo_content_type, :limit => 50
      t.integer :anexo_file_size
      t.datetime :anexo_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :anexos
  end
end
