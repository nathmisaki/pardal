class ProfilesController < InheritedResources::Base
  belongs_to :user, :optional => true, :singleton => true
  actions :show
end
