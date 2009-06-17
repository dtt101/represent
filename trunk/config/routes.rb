ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.connect 'portfolio', :controller => 'portfolio', :action => 'notfound'
  map.connect 'portfolio/:id', :controller => 'portfolio', :action => 'default'
  map.connect 'portfolio/:id/posts/:action', :controller => 'Portfolio::Posts'
  map.connect 'portfolio/:id/posts/:action/:post_id', :controller => 'Portfolio::Posts'
  map.connect 'portfolio/:id/posts/show/:post_id/comments/:action', :controller => 'Portfolio::Comments'
  map.connect 'portfolio/:id/posts/show/:post_id/comments/:action/:comment_id', :controller => 'Portfolio::Comments'
  map.connect 'portfolio/:id/contacts/:action', :controller => 'Portfolio::Contacts'
  map.connect 'portfolio/:id/contacts/:action/:contact_id', :controller => 'Portfolio::Contacts'
  map.connect 'portfolio/:id/education/:action', :controller => 'Portfolio::Education'
  map.connect 'portfolio/:id/education/:action/:institution_id', :controller => 'Portfolio::Education'
  map.connect 'portfolio/:id/qualification/:action', :controller => 'Portfolio::Qualification'
  map.connect 'portfolio/:id/qualification/:action/qualification_id', :controller => 'Portfolio::Qualification'
  map.connect 'portfolio/:id/experience/:action', :controller => 'Portfolio::Experience'
  map.connect 'portfolio/:id/experience/:action/:experience_id', :controller => 'Portfolio::Experience'
  map.connect 'portfolio/:id/activity/:action', :controller => 'Portfolio::Activity'
  map.connect 'portfolio/:id/activity/:action/:activity_id', :controller => 'Portfolio::Activity'
  map.connect 'portfolio/:id/meeting/:action', :controller => 'Portfolio::Meeting'
  map.connect 'portfolio/:id/meeting/:action/:meeting_id', :controller => 'Portfolio::Meeting'
  map.connect 'portfolio/:id/achievement/:action', :controller => 'Portfolio::Achievement'
  map.connect 'portfolio/:id/achievement/:action/:achievement_id', :controller => 'Portfolio::Achievement'
  map.connect 'portfolio/:id/links/:action', :controller => 'Portfolio::Links'
  map.connect 'portfolio/:id/links/:action/:achievement_id', :controller => 'Portfolio::Links'
  map.connect 'portfolio/:id/:action/:action_id', :controller => 'portfolio'
  map.root :controller => "home"
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
