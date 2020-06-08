Rails.application.routes.draw do
    get 'users/show'
    get 'users/edit'
    devise_for :users, :controllers => {
                         :registrations => 'users/registrations',
                         :passwords => 'users/passwords'
                        }
    mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
    root 'static_pages#top'
    get '/about' => 'static_pages#about'
    get '/contact' => 'static_pages#contact'
end
