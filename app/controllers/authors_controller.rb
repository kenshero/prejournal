class AuthorsController < ApplicationController
  def index
    if params[:q].present?
      @authors = Author.where("author_name LIKE ?" , "%#{params[:q]}%").paginate(:page => params[:page], :per_page => 100)
    else
      @authors = Author.paginate(:page => params[:page], :per_page => 100)
    end
  end

  def new
    @author = Author.new
  end

  def create
    # render plain: author_params
    @author = Author.new(author_params)
    if @author.save
      redirect_to authors_path
    else
      render 'new'
    end
  end

  def edit
    @author = Author.find(author_id)
  end

  def update
    @author = Author.find(author_id)
    if @author.update_attributes(author_params)
      redirect_to authors_path
    else
      render 'new'
    end
  end

  def destroy
    @author = Author.find(author_id)
    if @author.destroy
      redirect_to authors_path
    end
  end

  private
    def author_params
      params.require(:author).permit(:author_name)
    end

    def author_id
      params[:id]
    end
end
