# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "homes#top"
  get "about" => "homes#about"

  devise_for :members, controllers: {
    registrations: "member/registrations",
    sessions: "member/sessions"
  }

  devise_scope :member do
    get "/members/sign_out" => "devise/sessions#destroy"
  end

  devise_for :admins, controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :admin do
    get "/admins/sign_out" => "devise/sessions#destroy"
  end

  namespace :admin do
    get "search" => "searches#search"
    resources :companies, only: [:index, :show, :edit, :update]
    resources :comments, only: [:index, :show, :create, :edit, :update]
    resources :members, only: [:index, :show, :edit, :update, :destroy]
    resources :announcements
  end

  scope module: :member do
    get "search" => "searches#search"
    get "members/check" => "members#check"
    patch "members/withdraw" => "members#withdraw"
    resources :companies, except: [:destroy] do
      resources :comments, only: [:create, :new]
    end
    resources :comments, except: [:create, :new, :destroy] do
      resource :favorites, only: [:create, :destroy]
    end
    resources :members, only: [:show, :edit, :update]
    resources :messages, only: [:create, :destroy]
    resources :rooms, only: [:create, :show]
    resources :announcements
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
