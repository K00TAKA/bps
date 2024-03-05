Rails.application.routes.draw do

  root to: 'homes#top'

  #会員用
  # URL /members/sign_in ...
  devise_for :members, controllers: {
    registrations: "member/registrations",
    sessions: 'member/sessions'
  }

  devise_scope :member do
    get '/members/sign_out' => 'devise/sessions#destroy'
  end

  #管理者用
  # URL /admin/sign_in ...
  devise_for :admins, controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :admin do
    get '/admins/sign_out' => 'devise/sessions#destroy'
  end

  namespace :admin do
    get "search" => "searches#search"
    resources :companies, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :update]
    resources :comments, only: [:index, :show, :create, :edit, :update]
    resources :members, only: [:index, :show, :edit, :update, :destroy]
  end

  # namespaceを使うとURLにmemberが付くためscopeを使用
  scope module: :member do
    get "search" => "searches#search"
    get 'about' => 'homes#about'
    get 'members/check' => 'members#check'
    resources :companies, except: [:destroy]
    resources :comments, only: [:index, :show, :edit, :update] do
      resource :favorites, only: [:create, :destroy]
    end
    resources :members, only: [:show, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
