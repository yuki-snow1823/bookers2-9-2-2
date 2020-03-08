Rails.application.routes.draw do
  get '/search' => 'search#search', as: 'search'
  # get 'relationships/create'
  # get 'relationships/destroy'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
   }
# これのおかげで最初に動く:メールを送るため

  # 順番上にあげた
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member # 追加　多分不要
    get :followers, on: :member # 追加　多分不要
    # get :search, on: :collection
  end

  resources :chats, only: [:create, :show]
  resources :rooms, only: [:create]
  # ここだけ記事と少し違って、chatのshow…いや別にいいのか、アクションでチャットをするとかいう謎の記述だったし？でも一応


  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    # get :search, on: :collection
    # GET /books/searchでBooksコントローラのsearch アクションにルーティングされるようになります。
  end
  

  # 直るまでコメントアウト

  root 'home#top'
  get 'home/about'
end