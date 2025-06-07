module ProjectIssueStatuses
  module Patches
    module ProjectsControllerPatch
      def self.included(base)
        base.class_eval do
          before_action :load_issue_statuses_for_settings, only: [:settings]
        end
      end

      private

      def load_issue_statuses_for_settings
        Rails.logger.warn "[DEBUG] ==== load_issue_statuses_for_settings gọi với tab: #{request.path_parameters[:tab]}"
        # return unless request.path_parameters[:tab] == 'project_issue_statuses'
        
        @issue_statuses = IssueStatus.all
        @selected_status_ids = @project.issue_statuses.pluck(:id)
        Rails.logger.warn "[DEBUG] ==== load_issue_statuses_for_settings gọi với tab: #{@issue_statuses} #{@selected_status_ids}"
      end
    end
  end
end

unless ProjectsController.included_modules.include?(ProjectIssueStatuses::Patches::ProjectsControllerPatch)
  ProjectsController.send(:include, ProjectIssueStatuses::Patches::ProjectsControllerPatch)
end