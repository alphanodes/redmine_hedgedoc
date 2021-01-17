resource :hedgedoc, only: %i[show]

resources :projects, only: [] do
  resource :hedgedoc, only: %i[show]
end
