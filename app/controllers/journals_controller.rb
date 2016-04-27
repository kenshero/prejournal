class JournalsController < ApplicationController
  before_filter :authorize
  def index
    if params[:q].present?
      @journals = Journal.where("journal_name LIKE ?" , "%#{params[:q]}%").order('journal_name ASC')
    else
      @journals = Journal.order('journal_name ASC').all
    end
  end

  def new
    @journal = Journal.new
  end

  def create
    # render plain: journal_params
    @journal = Journal.new(journal_params)
    if @journal.save
      redirect_to journals_path
    else
      render 'new'
    end
  end

  def edit
    @journal = Journal.find(journal_id)
  end

  def update
    @journal = Journal.find(journal_id)
    if @journal.update_attributes(journal_params)
      redirect_to journals_path
    else
      render 'edit'
    end
  end

  def destroy
    @journal  = Journal.find(journal_id)
    if @journal.destroy
      redirect_to journals_path
    end
  end

  private
    def journal_params
      params.require(:journal).permit(:journal_name)
    end

    def journal_id
      params.require(:id)
    end
end
