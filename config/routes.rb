Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => "pickups#index"
  # Routes for the Pickup resource:
  # CREATE
  get "/pickups/new", :controller => "pickups", :action => "new"
  post "/create_pickup", :controller => "pickups", :action => "create"

  # READ
  get "/pickups", :controller => "pickups", :action => "index"
  get "/pickups/:id", :controller => "pickups", :action => "show"

  # UPDATE
  get "/pickups/:id/edit", :controller => "pickups", :action => "edit"
  post "/update_pickup/:id", :controller => "pickups", :action => "update"

  # DELETE
  get "/delete_pickup/:id", :controller => "pickups", :action => "destroy"
  #------------------------------

  devise_for :users
  # Routes for the User resource:
  # READ
  get "/users", :controller => "users", :action => "index"
  get "/users/:id", :controller => "users", :action => "show"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
