ActionController::Routing::Routes.draw do |map|

  map.resource :dashboard
  
  map.root :controller => "dashboards", :action => "show"
end
