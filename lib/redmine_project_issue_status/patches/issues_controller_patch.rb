module ProjectIssueStatuses
  module Patches
    module IssuesControllerPatch
      def self.included(base)
        base.class_eval do
          before_action :filter_statuses_by_project, only: [:new, :edit]

          def filter_statuses_by_project
            return unless @project && @project.respond_to?(:issue_statuses)

            @allowed_statuses = @project.issue_statuses
          end
        end
      end
    end
  end
end

unless IssuesController.included_modules.include?(ProjectIssueStatuses::Patches::IssuesControllerPatch)
  IssuesController.send(:include, ProjectIssueStatuses::Patches::IssuesControllerPatch)
end
