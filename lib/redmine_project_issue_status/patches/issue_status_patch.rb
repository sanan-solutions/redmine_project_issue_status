module RedmineProjectIssueStatus
  module Patches
    module IssueStatusPatch
      def self.included(base)
        base.class_eval do
          has_many :project_issue_statuses
          has_many :projects, through: :project_issue_statuses
        end
      end
    end
  end
end

unless IssueStatus.included_modules.include?(RedmineProjectIssueStatus::Patches::IssueStatusPatch)
  IssueStatus.include RedmineProjectIssueStatus::Patches::IssueStatusPatch
end
