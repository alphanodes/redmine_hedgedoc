resource :codimd, only: %i[show]

resources :projects, only: [] do
  resource :codimd, only: %i[show]
end
