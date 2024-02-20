Rails.application.routes.draw do

  root to: 'homes#top'

  #会員用
  # URL /members/sign_in ...
  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #管理者用
  # URL /admin/sign_in ...
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :companies, only: [:index, :show]
    resources :genres, only: [:index]
    resources :comments, only: [:index, :show]
    resources :members, only: [:index]
  end

  # namespaceを使うとURLにmemberが付くためscopeを使用
  scope module: :member do
    get 'about' => 'homes#about'
    get 'members/check' => 'members#check'
    resources :companies, only: [:index, :show, :edit]
    resources :comments, only: [:index, :show]
    resources :members, only: [:show, :edit]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
