Rails.application.routes.draw do

  # Authentication, registration
  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/users', to: redirect('/users/sign_in')

  # Admin Dashboard
  ActiveAdmin.routes(self)


  root 'home#index'

  # Error handling
  match '404', to: 'error#not_found', via: :all
  match '500', to: 'error#server_error', via: :all
  match '418', to: 'error#teapot', via: :all

  # Current schedule
  get 'schedule', to: 'schedules#current', as: 'current_schedule'

  # Standalone player
  # POST required for Facebook Tab Page.
  # TODO: the above was written by prev. webmaster. Check whether it's true
  match 'listen', to: 'player#listen', as: "listen", via: [:get, :post]

  # Events
  resources :events, only: ['show']

  # Shows
  resources :shows, only: ['show', 'index'] do
    # /shows/all will also display shows not in schedule
    get 'all', on: :collection
    resources :podcasts, only: ['show']
  end

  # Techteam page
  get 'techteam', to: 'techteam#index', as: 'techteam'

  # Report issue page
  get 'issue', to: 'issue#report', as: 'issue'
  post 'issue', to: 'issue#submit'
  get 'issue/submitted', to: 'issue#submitted', as: 'issue_submitted'


  scope 'api' do
    get 'users/:email/shows', to: 'api#shows_for_user', :constraints => { email: /[a-zA-Z0-9]+\@[a-zA-Z0-9]+\.[a-zA-Z]+/ }
    get 'schedules/current', to: 'api#current_schedule'
    get 'shows/:slug', to: 'api#show_by_slug'
    get 'shows/:slug/check-broadcast-time/:start(-:end)', to: 'api#check_broadcast_time', :constraints => { start: /[0-9]+/, end: /[0-9]+/ }
  end

  # OpenID
  scope '/oid', module: :open_id, as: :open_id do
    match '/'        => 'provider#index',     as: :index, via: [:get, :post]
    get   'me'       => 'provider#user_page', as: :user
    get   'me/xrds'  => 'provider#user_xrds', as: :user_xrds
    get   'decision' => 'provider#show_decision_page', as: :show_decision_page
    post  'decision' => 'provider#decision',  as: :decision
  end

  # Static pages
  # (should be at the end of the file not to mess with other routes)
  resources :pages, path: '/', only: ['show'] do
    resources :sub_pages, path: '/', only: ['show']
  end

end
