module ProjectIssueStatuses
  module Patches
    module ProjectPatch
      def self.included(base)
        base.class_eval do
          has_many :project_issue_statuses, dependent: :destroy
          has_many :issue_statuses, through: :project_issue_statuses

          def rolled_up_statuses
            tracker_ids = rolled_up_trackers.map(&:id)
    
            status_ids = WorkflowTransition.
              where(tracker_id: tracker_ids).
              distinct.
              pluck(:old_status_id, :new_status_id).
              flatten.
              uniq
    
            if self.respond_to?(:issue_statuses) && issue_statuses.any?
              filtered_ids = issue_statuses.pluck(:id) & status_ids
              IssueStatus.where(id: filtered_ids).sorted
            else
              IssueStatus.where(id: status_ids).sorted
            end
          end
        end

        
      end
    end
  end
end

unless Project.included_modules.include?(ProjectIssueStatuses::Patches::ProjectPatch)
  Project.send(:include, ProjectIssueStatuses::Patches::ProjectPatch)
end