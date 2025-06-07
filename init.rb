Redmine::Plugin.register :redmine_project_issue_status do
  name 'Redmine Project Issue Status'
  author 'SanAn'
  description 'Allow each project to manage its own issue statuses'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  permission :view_project_issue_statuses, { project_issue_statuses: [:index] }, public: true
  permission :update_project_issue_statuses, { project_issue_statuses: [:update] }, require: :member
end

require_relative 'lib/redmine_project_issue_status/patches/projects_helper_patch'
require_relative 'lib/redmine_project_issue_status/patches/project_patch'
require_relative 'lib/redmine_project_issue_status/patches/issue_status_patch'
require_relative 'lib/redmine_project_issue_status/patches/projects_controller_patch'
require_relative 'lib/redmine_project_issue_status/patches/issues_controller_patch'
