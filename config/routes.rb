Rails.application.routes.draw do
    devise_for :users, controllers: {
                                 :registrations => 'users/registrations',
                                 :passwords => 'users/passwords'
                                }
    devise_scope :user do
      patch 'users/tag', to: 'users/registrations#update_tag', as: 'tag_registration'
    end
    mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
    root 'static_pages#top'
    get '/about', to: 'static_pages#about'
    get '/contact', to: 'static_pages#contact'
    resource :users, only: [:show] do
        resources :labels, only: [:new, :create, :update, :destroy]
        resources :categories, only: [:create, :update, :destroy]
        resources :hyles do
            collection do
                get :categorized_index
                get :tagged_index
            end
        end
    end
end
