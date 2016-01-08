class ArticlesController < ApplicationController
  def index
    @journal = get_journal_id
    @issue   = get_issue_id
    @articles = @issue.articles.all
  end

  def new
    @journal = get_journal_id
    @issue   = get_issue_id
    @article = @issue.articles.new
  end

  def create
    @journal = get_journal_id
    @issue   = get_issue_id
    @article = @issue.articles.new(article_params)
    if @article.save
      redirect_to journal_issue_articles_path
    else
      render 'new'
    end
  end

  def edit
    @journal = get_journal_id
    @issue   = get_issue_id
    @article = get_article_id
  end

  def update
    @journal = get_journal_id
    @issue   = get_issue_id
    @article = get_article_id
    if @article.update_attributes(article_params)
      redirect_to journal_issue_articles_path
    else
      render 'edit'
    end
  end

  def destroy
    @journal = get_journal_id
    @issue   = get_issue_id
    @article = get_article_id
    if @article.destroy
      redirect_to journal_issue_articles_path
    end
  end

  private
    def article_params
      params.require(:article).permit(:article_name_th)
    end

    def get_article_id
      @issue.articles.find(params.require(:id))
    end

    def get_journal_id
      Journal.find(params[:journal_id])
    end

    def get_issue_id
      @journal.issues.find(params[:issue_id])
    end
end