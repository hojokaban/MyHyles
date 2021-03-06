class ErrorAvoid
  def initialize
    @url = "attachments/"
  end

  def matches?(request)
    @url.include?(request.url)
  end
end

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
  get '/artificial_batch', to: 'application#artificial_batch'
  resource :users, only: [:show] do
    patch '/:tag', to: 'users#update', as: 'delete_tag'
    resources :labels, only: [:edit, :create, :update, :destroy]
    resources :categories, only: [:create, :update, :destroy]
    resources :hyles do
      member do
        get :categorized_index, as: 'categorized'
        get :tagged_index, as: 'tagged'
      end
    end
    resources :memories
    resources :daily_relationships, only: [:new, :update] do
      resource :hyle_daily_relationships, only: [:create, :destroy]
    end
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  get '*path', controller: 'application', action: 'render_404', constraints: ErrorAvoid.new
end
