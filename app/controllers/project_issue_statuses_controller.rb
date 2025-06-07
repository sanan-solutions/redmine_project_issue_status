class ProjectIssueStatusesController < ApplicationController
  before_action :find_project
  before_action :authorize_project_issue_status_update

  def index
    @issue_statuses = IssueStatus.all
    @selected_status_ids = @project.issue_statuses.pluck(:id)
  end

  def update
    @project.project_issue_statuses.destroy_all
    Rails.logger.debug "==> issue_status_ids: #{params[:issue_status_ids].inspect}"
    if params[:issue_status_ids]
      params[:issue_status_ids].each do |status_id|
        @project.project_issue_statuses.create(issue_status_id: status_id)
      end
    end
    flash[:notice] = "Project issue statuses updated."
    redirect_to settings_project_path(@project, tab: 'project_issue_statuses')
  end

  private

  def authorize_project_issue_status_update
    unless User.current.admin? || User.current.allowed_to?(:update_project_issue_statuses, @project)
      render_403
    end
  end

  def find_project
    @project = Project.find(params[:project_id])
  end
end
