Rails.application.routes.draw do
  devise_for :users
    root 'static_pages#top'
    get '/about' => 'static_pages#about'
    get '/contact' => 'static_pages#contact'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
