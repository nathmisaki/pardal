class CreatePeriods < ActiveRecord::Migration
  def self.up
    create_table :periods do |t|
      t.string :name, :limit => 15

      t.timestamps
    end
  end

  def self.down
    drop_table :periods
  end
end
