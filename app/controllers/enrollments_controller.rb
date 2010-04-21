class EnrollmentsController < InheritedResources::Base
  belongs_to :student
  actions :index, :new, :create
end
