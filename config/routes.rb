Rails.application.routes.draw do

  devise_for :users, controllers: {sessions: 'users/sessions'}
  resources :dones

  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy', as: :logout
  resources :users, only: [:new, :create] do
  collection do
    match 'password_forgot', as: :password_forgot, via: [:get, :post]

    get 'reset_password/:token' => 'users#reset_password', as: :reset_password
  end
end
  resources :exams
  resources :students
  get "/" => "questions#index"

  get "/student_dones/:student_id/:done_id" => "dones#show"

  get "/exam/all" => "exams#all"

  post "/dones/teste" => "dones#criar"

	get "/about_us" => "home#about"
  get "/students" => "students#index"
	get "/faq" => "home#faq"

	get "/help" => "help#index"

  resources :questions
  get '/discover' => "questions#discover"

  post '/like' => "questions#like"

  post '/dislike' => "questions#dislike"

	#resources :questions, only: [:index, :create, :show] do
	#    member do
  # 	      post :vote_up
  #	      post :vote_down
  #  	    end
  #  	post :search, on: :collection
  #	end
end
