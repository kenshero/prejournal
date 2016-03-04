module Api
  module V1
    class JournalsController < ApplicationController
      respond_to :json 
      skip_before_action :verify_authenticity_token, only: [:facet]
      require 'hashie'
      def index
        respond_with Journal.all
      end

      def search
        text_search = params[:textSearch]
        page    = params[:page].to_i
        @data   = Article.article_search(text_search,page)
        @amount = Article.article_search(text_search,page).results.total
        @journals_facet = @data.response["aggregations"]["by_journal"]["buckets"]
        @years_facet    = @data.response["aggregations"]["by_year"]["buckets"]
        @keywords_facet = @data.response["aggregations"]["by_keywords"]["buckets"]
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
                       years_facet: @years_facet,
                       keywords_facet: @keywords_facet
                    }
        respond_with @response
      end

      def suggestion
        text_suggest = params[:textSuggest]
        @data   = Article.article_suggestion(text_suggest)
        @response = {  data: @data }
        respond_with @response
      end

      def facet
        text_facet  = params[:params][:facets]
        text_search = params[:textSearch]
        page = params[:page].to_i

        if text_facet.nil?
          puts "GGGGGGGGGGGGGGGGGG"
          @data   = Article.article_search(text_search,page)
          @amount = Article.article_search(text_search,page).results.total
          @journals_facet = @data.response["aggregations"]["by_journal"]["buckets"]
          @years_facet = @data.response["aggregations"]["by_year"]["buckets"]
          @keywords_facet = @data_facet.response["aggregations"]["by_keywords"]["buckets"]
          @response = { data: @data, 
                        amount: @amount,
                        journals_facet: @journals_facet,
                        years_facet: @years_facet,
                        keywords_facet: @keywords_facet
                      }
        else
          @data   = Article.article_facet(text_search,text_facet,page)
          @amount = Article.article_facet(text_search,text_facet,page).results.total
          @data_facet = Article.article_search(text_search,page)
          @journals_facet = @data_facet.response["aggregations"]["by_journal"]["buckets"]
          @years_facet    = @data_facet.response["aggregations"]["by_year"]["buckets"]
          @keywords_facet = @data_facet.response["aggregations"]["by_keywords"]["buckets"]
          # puts @data
          # # puts "#{@data}  ssss #{@journals_facet}"
          # # @journals  = Journal.find(journal_id)
          # # @issues    = @journals.issues.all
          @response = { data: @data, 
                        amount: @amount,
                        journals_facet: @journals_facet,
                        years_facet: @years_facet,
                        keywords_facet: @keywords_facet
                      }
        end #endif
        render json: @response
      end
    end
  end
end