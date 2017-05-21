class IssueController < ApplicationController

  def report
    @title = 'Report an issue'
    @issue = Issue.new
  end

  def submit
    @issue = Issue.new(params.require(:issue).permit(:description, :email))

    if @issue.save
      redirect_to issue_submitted_path
    else
      render 'report'
    end
  end

  def submitted
    @title = 'Issue successfully submitted'
  end
end
