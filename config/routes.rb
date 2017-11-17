Rails.application.routes.draw do
  
  root to: 'items#index'

  #devise_score :user do
    #get "/users/sign_out" => "devise/sessions#destroy"
  #end
  # Вызвав метод resources и передал ему в качестве аргумента названи контролера
  resources :items do # и передал ещё ему блок в нутри которого обясняю что екшен upvote должен быть доступен для ресуркаса items
    get :upvote, on: :member # вызываю метод get и передаю аргумент :upvote, второй аргумент on: значения етой опции :member
    get :expensive, on: :collection # цей екшен пренимаеться ко всей колекции
  end

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { registrations: "users/registrations" }

  match 'admin/users_count', :to => "admin#users_count", :via => [:get]
end
