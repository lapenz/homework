Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  resources :sections do
    resources :questions
  end
  resources :lessons
  resources :books

  get '/sections/:section_id/destroyUserSection', to: 'sections#destroyUserSection', as: 'destroyUserSection'

  get '/dashboard', to: 'dashboards#index'
  get '/dashboard/:book_id/lessons', to: 'dashboards#lessons', as: 'book_lessons'
  get '/dashboard/:lesson_id/sections', to: 'dashboards#sections', as: 'lesson_sections'
  get '/dashboard/:section_id/answer_questions', to: 'dashboards#answer_questions', as: 'answer_questions'
  post '/dashboard/verify_answer', to: 'dashboards#verify_answer', as: 'verify_answer'
  get '/dashboard/:section_id/close_section', to: 'dashboards#close_section', as: 'close_section'
  get '/dashboard/:section_id/result', to: 'dashboards#result', as: 'result'
  get '/dashboard/:section_id/result_questions', to: 'dashboards#result_questions', as: 'result_questions'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # authenticated :user do
  #   root 'dashboard#index', as: :authenticated_root
  # end

  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
