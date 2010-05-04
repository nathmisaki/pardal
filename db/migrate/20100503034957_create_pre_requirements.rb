class CreatePreRequirements < ActiveRecord::Migration
  def self.up
    create_table :pre_requirements do |t|
      t.belongs_to :implementation
      t.belongs_to :pre_requirement

      t.timestamps
    end
  end

  def self.down
    drop_table :pre_requirements
  end
end
