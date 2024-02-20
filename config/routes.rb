Rails.application.routes.draw do

  #会員用
  # URL /members/sign_in ...
  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :companies, :genres, :comments
  end

  # namespaceを使うとURLにmemberが付くためscopeを使用
  scope module: :member do
    root to: 'homes#top'
    get 'members/check' => 'members#check'
    resources :companies, :comments, :members
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
