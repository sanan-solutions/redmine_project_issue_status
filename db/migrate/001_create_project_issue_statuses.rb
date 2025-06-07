class CreateProjectIssueStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :project_issue_statuses do |t|
      t.integer :project_id, null: false
      t.integer :issue_status_id, null: false
      t.timestamps
    end

    add_index :project_issue_statuses, [:project_id, :issue_status_id], unique: true, name: 'index_project_status_unique'
    add_foreign_key :project_issue_statuses, :projects, column: :project_id
    add_foreign_key :project_issue_statuses, :issue_statuses, column: :issue_status_id
  end
end
