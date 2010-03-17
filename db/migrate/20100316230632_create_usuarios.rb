class CreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table :usuarios do |t|
      t.authenticatable
      t.confirmable
      t.registerable
      t.recoverable
      t.rememberable
      t.trackable
      t.timestamps
    end
  end

  def self.down
    drop_table :usuarios
  end
end
