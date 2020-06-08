Rails.application.routes.draw do
    devise_for :users, controllers: {
                                 :registrations => 'users/registrations',
                                 :passwords => 'users/passwords'
                                }
    mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
    root 'static_pages#top'
    get '/about', to: 'static_pages#about'
    get '/contact', to: 'static_pages#contact'
    resource :users, only: [:show]
end
