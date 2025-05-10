Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }, path: '', path_names: {
    sign_up: 'signup',
    sign_in: 'login',
    sign_out: 'logout',
    edit: 'account/edit'
  }

  # アカウント設定・プロフィール関連
  resource :users, only: [] do
    get "profile"
    get "profile/edit", to: "users#edit_profile"
    patch "profile", to: "users#update_profile", as: "update_profile"
    get "account", to: "users#account"
    put "account", to: "users#update_account"
  end

  # 施設関連
  resources :rooms do
    collection do
      get 'search', to: 'rooms#search' # 施設検索用のルート
      get 'own', to: 'rooms#own' # 登録済ルーム一覧用のルート
    end
  end

  # 予約関連
  resources :reservations do
    collection do
      post :confirm
    end
  end

  root 'home#index'
end

