# frozen_string_literal: true

Rails.application.routes.draw do
  root 'web/base#index'

  namespace :web, path: '/', as: '' do
    resources :categories, only: %i[show new create destroy]
  end
end
