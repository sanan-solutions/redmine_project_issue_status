class CreateProjectIssueStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :project_issue_statuses do |t|
      t.references :project, null: false, foreign_key: true
      t.references :issue_status, null: false
      t.timestamps
    end
    add_index :project_issue_statuses, [:project_id, :issue_status_id], unique: true, name: 'index_project_status_unique'
  end
end
