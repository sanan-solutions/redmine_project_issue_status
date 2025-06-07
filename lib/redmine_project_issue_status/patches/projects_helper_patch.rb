module RedmineProjectIssueStatus
  module Patches
    module ProjectsHelperPatch
      def self.included(base)
        base.class_eval do
          # Alias lại hàm project_settings_tabs
          def project_settings_tabs_with_issue_statuses
            tabs = project_settings_tabs_without_issue_statuses
            tabs << {
              name: 'project_issue_statuses',
              action: :edit_project,
              partial: 'projects/settings/issue_statuses',
              label: :label_project_issue_statuses
            }
            tabs
          end

          unless method_defined?(:project_settings_tabs_without_issue_statuses)
            alias_method :project_settings_tabs_without_issue_statuses, :project_settings_tabs
            alias_method :project_settings_tabs, :project_settings_tabs_with_issue_statuses
          end
        end
      end
    end
  end
end

unless ProjectsHelper.included_modules.include?(RedmineProjectIssueStatus::Patches::ProjectsHelperPatch)
  ProjectsHelper.send(:include, RedmineProjectIssueStatus::Patches::ProjectsHelperPatch)
end
