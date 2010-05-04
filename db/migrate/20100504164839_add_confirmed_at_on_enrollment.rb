class AddConfirmedAtOnEnrollment < ActiveRecord::Migration
  def self.up
    add_column :enrollments, :confirmed_at, :datetime
  end

  def self.down
    remove_column :enrollments, :confirmed_at
  end
end
