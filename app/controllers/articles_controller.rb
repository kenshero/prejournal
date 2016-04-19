class ArticlesController < ApplicationController
  respond_to :json
  before_filter :authorize
  autocomplete :author, :author_name
  def index
    @journal = get_journal_id
    @year    = get_year_id
    @issue   = get_issue_id
    @articles = @issue.articles.all
  end

  def new
    @journal = get_journal_id
    @year    = get_year_id
    @issue   = get_issue_id
    @article = @issue.articles.new
  end

  def create
    # render plain: article_params
    @journal = get_journal_id
    @year    = get_year_id
    @issue   = get_issue_id
    @article = @issue.articles.new(article_params)
    if @article.save
      redirect_to journal_year_issue_articles_path
    else
      render 'new'
    end
  end

  def edit
    @journal = get_journal_id
    @year    = get_year_id
    @issue   = get_issue_id
    @article = get_article_id
  end

  def update
    # render plain: article_params
    @journal = get_journal_id
    @year    = get_year_id
    @issue   = get_issue_id
    @article = get_article_id
    if @article.update_attributes(article_params)
      redirect_to journal_year_issue_articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @journal = get_journal_id
    @year    = get_year_id
    @issue   = get_issue_id
    @article = get_article_id
    if @article.destroy
      redirect_to journal_year_issue_articles_path
    end
  end

  def autocomplete_article_name
    if params[:term]
      text_search = params[:term]
      # puts text_search
      @authors_search = Author.where("author_name LIKE ?" , "%#{text_search}%").limit(7)
      puts @authors_search[0].author_name
      respond_with(@authors_search)
      else
        puts "sss"
    end
  end

  private
    def article_params
      params.require(:article).permit(:article_name,{ keywords: [] , author_name: [] , author_ids: []})
    end

    def get_journal_id
      Journal.find(params[:journal_id])
    end

    def get_year_id
      @journal.years.find(params.require(:year_id))
    end
    
    def get_issue_id
      @year.issues.find(params.require(:issue_id))
    end

    def get_article_id
      @issue.articles.find(params.require(:id))
    end


end
