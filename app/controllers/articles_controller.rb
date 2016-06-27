require 'net/http'
class ArticlesController < ApplicationController
  respond_to :json
  before_filter :authorize
  autocomplete :author, :author_name
  def index
    @journal = get_journal_id
    @year    = get_year_id
    @issue   = get_issue_id
    @articles = @issue.articles.all.order('article_name ASC')
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
      @article.update_authors_role(authortype_param)
      @article.update_keywords_role(keywords_role_params)
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
    # render plain: authortype_param
    params[:article][:author_name] = [""] if params[:article][:author_name].nil?
    @journal = get_journal_id
    @year    = get_year_id
    @issue   = get_issue_id
    @article = get_article_id
    if @article.update_attributes(article_params)
      @article.update_authors_role(authortype_param)
      @article.update_keywords_role(keywords_role_params)
      redirect_to journal_year_issue_articles_path
    else
      render 'edit'
    end
  end

  def show
    @article = Article.find(params[:id])
    
    # journal = @article.issue.year.journal.journal_name
    # year    = @article.issue.year.journal_year
    # issue   = @article.issue.number

    # @article.pdf_path =  encode_tis(journal,year,issue,@article.article_name)

    # puts @article.pdf_path.to_s
    # @article.pdf_path = @article.pdf_path[28..-1]
    # puts @article.as_json
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

  def articles_all
    if params[:q].present?
      @articles = Article.where("article_name LIKE ?" , "%#{params[:q]}%").paginate(:page => params[:page], :per_page => 100)
    else
      @articles = Article.paginate(:page => params[:page], :per_page => 100)
    end
    render "articles/index.all"
  end

  private
    def article_params
      params.require(:article).permit(:article_name,:pdf_path,{ keywords: [] , author_name: [] , author_ids: [], keyword_role: [] })
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

    def authortype_param
      params[:author_role]
    end

    def keywords_role_params
      params[:keywords_role]
    end

end
