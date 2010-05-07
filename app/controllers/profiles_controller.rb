class ProfilesController < InheritedResources::Base
  belongs_to :user, :singleton => true
  actions :show
end
