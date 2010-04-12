class CreateEnrollmentSituations < ActiveRecord::Migration
  def self.up
    create_table :enrollment_situations do |t|
      t.string :description
      t.boolean :valid

      t.timestamps
    end
  end

  def self.down
    drop_table :enrollment_situations
  end
end
