class YearsController < ApplicationController
  before_filter :authorize
  def index
    @journal = get_journal_id
    @years   = @journal.years.all
  end

  def new
    @journal = get_journal_id
    @year = @journal.years.new
  end

  def create
    @journal = get_journal_id
    @year = @journal.years.new(year_params)
    if @year.save
      redirect_to journal_years_path
    else
      render 'new'
    end
  end

  def edit
    @journal = get_journal_id
    @year   = @journal.years.find(params.require(:id))
  end

  def update
    @journal = get_journal_id
    @year   = get_year_id
    if @year.update_attributes(year_params)
      redirect_to journal_years_path
    else
      render 'edit'
    end
  end

  def destroy
    @journal = get_journal_id
    @year = get_year_id
    if @year.destroy
      redirect_to journal_years_path
    end
  end

  private
    def year_params
      params.require(:year).permit(:journal_year)
    end

    def get_journal_id
      Journal.find(params[:journal_id])
    end

    def get_year_id
      @journal.years.find(params.require(:id))
    end
end
