ActionController::Routing::Routes.draw do |map|
  map.resources :helps

  map.devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  map.user_root '/me', :controller => :current_users, :action => :show, :conditions => { :method => :get }
  map.resource :current_user, :only => [:show, :edit, :update], :as => "me", :member => { :link_student => :get }

  map.resources :users, :only => :show do |user|
    user.resources :attachments
  end

  map.resources :students, :has_many => :enrollments

  map.root :controller => "home"
  map.connect "/v3", :controller => "home"

end
