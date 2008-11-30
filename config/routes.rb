ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => "invoices", :action => "index"
  
  map.connect 'invoices/page/:page', :controller => 'invoices', :action => 'index'
  
  map.resources :invoices, :collection => { :search => :post } do |invoices|
    invoices.resources :invoice_lines, :as => 'lines'
  end

  
  map.resources :customers, :collection => {:select => :post} do |customers|
    customers.resources :invoices, :name_prefix => "customer_"
  end
  
  map.resources :users
  
  map.with_options :controller => 'invoices', :action => 'public_invoices' do |map|
    map.public_invoices '/customers/:customer_id/:private_key/invoices.:format'
    map.public_invoices '/customers/:customer_id/:private_key/invoices'
  end
  
 
  
  map.connect ':controller/:action/:id'
  
end
