class AddCurriculumOnStudent < ActiveRecord::Migration
  def self.up
    add_column :students, :curriculum_id, :integer
  end

  def self.down
    remove_column :students, :curriculum_id
  end
end
