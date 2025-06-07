Rails.application.routes.draw do
  resources :projects do
    resource :project_issue_statuses, only: [:index, :update]
  end
end
