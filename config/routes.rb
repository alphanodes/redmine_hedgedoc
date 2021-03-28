# frozen_string_literal: true

Rails.application.routes.draw do
  resource :hedgedoc, only: %i[show]

  resources :projects, only: [] do
    resource :hedgedoc, only: %i[show]
  end
end
