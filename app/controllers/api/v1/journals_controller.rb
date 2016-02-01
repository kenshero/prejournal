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
        @data   = Article.article_search(text_search,page)
        @amount = Article.article_search(text_search,page).results.total
        @journals_facet = @data.response["aggregations"]["by_journal"]["buckets"]
        @years_facet = @data.response["aggregations"]["by_year"]["buckets"]
        # puts @amount
        # binding.pry
        # puts @data.first.inspect
        # arr_json = []
        # @data.each do | article |
        #   @issue = article.issue
        #   @year = @issue.year
        #   @journal = @year.journal
        #   # binding.pry

        #   @article_json = JSON.parse(article.to_json)
        #   @issue_json = JSON.parse(@issue.to_json)
        #   @year_json = JSON.parse(@year.to_json)
        #   @journal_json = JSON.parse(@journal.to_json)

        #   year_json = @year_json.merge!(@issue_json)
        #   issue_journal = year_json.merge!(@article_json)
        #   merge_data = @journal_json.merge!(issue_journal)
        #   arr_json << merge_data
        # end
        # puts arr_json
        @response = {  data: @data, 
                       amount: @amount,
                       journals_facet: @journals_facet,
                       years_facet: @years_facet
                    }
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