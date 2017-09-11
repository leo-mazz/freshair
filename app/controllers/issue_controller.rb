class IssueController < ApplicationController

  def report
    @title = 'Report an issue'
    @issue = Issue.new
  end

  def submit
    @issue = Issue.new(params.require(:issue).permit(:description, :email))

    if @issue.save
      redirect_to issue_submitted_path
      GenericMailer.new_issue(@issue).deliver_later
    else
      render 'report'
    end
  end

  def submitted
    @title = 'Issue successfully submitted'
  end
end
