Rails.application.routes.draw do
    devise_for :users, controllers: {
                                 :registrations => 'users/registrations',
                                 :passwords => 'users/passwords'
                                }
    devise_scope :user do
      patch 'users/tag', to: 'users/registrations#update_tag', as: 'tag_registration'
    end
    root 'static_pages#top'
    get '/about', to: 'static_pages#about'
    get '/contact', to: 'static_pages#contact'
    resource :users, only: [:show] do
        resources :labels, only: [:edit, :create, :update, :destroy]
        resources :categories, only: [:create, :update, :destroy]
        resources :hyles do
            member do
                get :categorized_index, as: 'categorized'
                get :tagged_index, as: 'tagged'
            end
        end
        resources :memories
        resource :daily_relationships, only: [:new, :update] do
          resources :hyle_daily_relationships, only: [:create, :destroy]
        end
    end
    mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
