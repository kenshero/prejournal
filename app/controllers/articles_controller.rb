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
      @article.update_role(authortype_param)
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
      @article.update_role(authortype_param)
      # map_role_author
      redirect_to journal_year_issue_articles_path
    else
      render 'edit'
    end
  end

  def show
    @article = Article.find(params[:id])
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
      params.require(:article).permit(:article_name,:pdf_path,{ keywords: [] , author_name: [] , author_ids: [] })
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

    # def map_role_author
    #   puts "#{authortype_param} sssssss"
    #   # puts @article.inspect
    #   @article.author_ids.each_with_index do |id_author,index|
    #     puts id_author
    #     author_article = ArticleAuthor.find_by(author_id: id_author ,article_id: @article.id)
    #     puts author_article.inspect
    #     puts authortype_param["author_role_#{index+1}"]
    #     author_article.authortype = authortype_param["author_role_#{index+1}.to_i"]
    #     author_article.save
    #   end
    #   # s
    # end

end
