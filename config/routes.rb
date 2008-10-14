ActionController::Routing::Routes.draw do |map|

  map.resource :dashboard
  map.resource :session
  map.resources :contents

  map.namespace :admin do |admin|
    admin.resources :pages, :collection => { :sort => :any }
    admin.resources :phrases
    admin.resources :updates
    admin.resources :resets
    admin.resources :contents
  end

  map.login "/login", :controller => "sessions", :action => "new"
  map.logout "/logout", :controller => "sessions", :action => "destroy"
  
  map.root :controller => "dashboards", :action => "show"
  
end
