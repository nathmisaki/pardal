class CreateAlunos < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.string     :registration,                :limit => 10
      t.string     :name,                        :limit => 100
      t.string     :identity,                    :limit => 20
      t.string     :identity_state,              :limit => 2
      t.string     :identity_emission_organ
      t.date       :identity_emission_date
      t.string     :elector_title,               :limit => 15
      t.string     :electoral_zone,              :limit => 5
      t.date       :birth_date
      t.string     :gender,                      :limit => 1
      t.string     :birth_city,                  :limit => 50
      t.string     :birth_state,                 :limit => 2
      t.string     :birth_country,               :limit => 3
      t.string     :father_name,                 :limit => 100
      t.string     :mother_name,                 :limit => 100
      t.string     :address_path,                :limit => 20
      t.string     :address_streetname,          :limit => 70
      t.string     :address_number,              :limit => 15
      t.string     :address_complement,          :limit => 255
      t.string     :address_neighbourhood,       :limit => 30
      t.string     :address_municipality,        :limit => 50
      t.string     :address_state,               :limit => 2
      t.string     :address_postal_code,         :limit => 8
      t.string     :phone,                       :limit => 15
      t.string     :high_school_name,            :limit => 50
      t.string     :high_school_municipality,    :limit => 50
      t.string     :high_school_state,           :limit => 2
      t.string     :high_school_conclusion_year, :limit => 4
      t.string     :ingress_form,                :limit => 1
      t.string     :high_school_type,            :limit => 1
      t.string     :education,                   :limit => 1
      t.string     :university,                  :limit => 1
      t.date       :ingress_exam_date
      t.integer    :ingress_exam_classification
      t.float      :ingress_exam_points
      t.belongs_to :course_implementation

      t.timestamps

      t.index      :registration
      t.index      :name
      t.index      :course_implementation
    end
  end

  def self.down
    drop_table :students
  end
end
