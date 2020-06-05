Rails.application.routes.draw do
    root 'static_pages#top'
    get '/about' => 'static_pages#about'
    get '/contact' => 'static_pages#contact'
end
