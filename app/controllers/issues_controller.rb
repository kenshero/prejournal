class IssuesController < ApplicationController
  def index
    @journal = get_journal_id
    @year    = get_year_id
    @issues  = @year.issues.all
  end

  def new
    @journal = get_journal_id
    @year    = get_year_id
    @issue   = @year.issues.new
  end

  def create
    @journal = get_journal_id
    @year    = get_year_id
    @issue   = @year.issues.new(issue_params)
    if @issue.save
      redirect_to journal_year_issues_path
    else
      render 'new'
    end
  end

  def edit
    @journal = get_journal_id
    @year    = get_year_id
    @issue   = get_issue_id
  end

  def update
    @journal = get_journal_id
    @year    = get_year_id
    @issue   = get_issue_id
    if @issue.update_attributes(issue_params)
      redirect_to journal_year_issues_path
    else
      render 'edit'
    end
  end

  def destroy
    @journal = get_journal_id
    @year    = get_year_id
    @issue   = get_issue_id
    if @issue.destroy
      redirect_to journal_year_issues_path
    end
  end

  private
    def issue_params
      params.require(:issue).permit(:number,:volume)
    end

    def get_journal_id
      Journal.find(params[:journal_id])
    end

    def get_year_id
      @journal.years.find(params.require(:year_id))
    end
    
    def get_issue_id
      @year.issues.find(params.require(:id))
    end
end