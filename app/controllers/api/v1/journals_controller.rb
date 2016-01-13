module Api
  module V1
    class JournalsController < ApplicationController
      respond_to :json
      require 'hashie'
      def index
        respond_with Journal.all
      end

      def search
        text_search = params[:textSearch]
        page   = params[:page].to_i
        @data   = Article.article_search(text_search,page).records
        @amount = Article.article_search(text_search,page).results.total
        puts @amount
        # binding.pry
        # puts @data.first.inspect
        arr_json = []
        @data.each do | article |
          @issue = article.issue
          @journal = @issue.journal
          @article_json = JSON.parse(article.to_json)
          @issue_json = JSON.parse(@issue.to_json)
          @journal_json = JSON.parse(@journal.to_json)

          issue_journal = @issue_json.merge!(@article_json)
          merge_data = @journal_json.merge!(issue_journal)
          arr_json << merge_data
        end
        # puts arr_json
        @response = {data: arr_json, amount: @amount}
        respond_with @response
      end

      # def search_issues
      #   journal_id = params[:journal_id]
      #   @journals  = Journal.find(journal_id)
      #   @issues    = @journals.issues.all
      #   respond_with @issues
      # end

      # def search_articles
      #   issue_id = params[:issue_id]
      #   @issue   = Issue.find(issue_id)
      #   @articles  = @issue.articles.all
      #   respond_with @articles
      # end

      # def get_article
      #   article_id = params[:article_id]

      #   @article   = Article.find(article_id)
      #   @issue     = @article.issue
      #   @journal   = @issue.journal
      #   @authors   = @article.authors
      #   @data = [@article, @issue, @journal,@authors]
      #   # @articles  = @issue.articles.all
      #   respond_with @data
      # end

      # def get_author
      #   author_id = params[:author_id]
      #   @author   = Author.find(author_id)
      #   @articles = @author.articles

      #   @response = {articles: @articles, author: @author}
      #   respond_with @response
      # end

    end
  end
end