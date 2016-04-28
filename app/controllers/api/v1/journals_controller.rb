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
        # text_search = params[:textSearch]
        # page    = params[:page].to_i
        # @data   = Article.article_search(text_search,page)
        # @amount = Article.article_search(text_search,page).results.total
        # @journals_facet = @data.response["aggregations"]["by_journal"]["buckets"]
        # @years_facet    = @data.response["aggregations"]["by_year"]["buckets"]
        # @keywords_facet = @data.response["aggregations"]["by_keywords"]["buckets"]
        # # puts @amount
        # # binding.pry
        # # puts @data.first.inspect
        # # arr_json = []
        # # @data.each do | article |
        # #   @issue = article.issue
        # #   @year = @issue.year
        # #   @journal = @year.journal
        # #   # binding.pry

        # #   @article_json = JSON.parse(article.to_json)
        # #   @issue_json = JSON.parse(@issue.to_json)
        # #   @year_json = JSON.parse(@year.to_json)
        # #   @journal_json = JSON.parse(@journal.to_json)

        # #   year_json = @year_json.merge!(@issue_json)
        # #   issue_journal = year_json.merge!(@article_json)
        # #   merge_data = @journal_json.merge!(issue_journal)
        # #   arr_json << merge_data
        # # end
        # # puts arr_json
        # @response = {  data: @data, 
        #                amount: @amount,
        #                journals_facet: @journals_facet,
        #                years_facet: @years_facet,
        #                keywords_facet: @keywords_facet
        #             }
        # respond_with @response
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

        ################ textfacet processing ################
        if text_facet[0].length == 0
          @journal_import_facet = []
          data_facet     = Article.article_search(text_search,page)
          journals_key = data_facet.response["aggregations"]["by_journal"]["buckets"]
          journals_key.each do |key|
            @journal_import_facet << key[:key]
          end 
          text_facet[0] = @journal_import_facet
        end

        if text_facet[1].length == 0
          @year_import_facet = []
          data_facet     = Article.article_search(text_search,page)
          years_key = data_facet.response["aggregations"]["by_year"]["buckets"]
          years_key.each do |key|
            @year_import_facet << key[:key]
          end 
          text_facet[1] = @year_import_facet
        end

        # if text_facet[2].length == 0
        #   @keywords_import_facet = []
        #   data_facet     = Article.article_search(text_search,page)
        #   keywords_key = data_facet.response["aggregations"]["by_keywords"]["buckets"]
        #   keywords_key.each do |key|
        #     @keywords_import_facet << key[:key]
        #   end 
        #   text_facet[2] = @keywords_import_facet
        #   text_facet[2] << ""
        # end

        # if text_facet[3].length == 0
        #   @author_import_facet = []
        #   data_facet     = Article.article_search(text_search,page)
        #   authors_key = data_facet.response["aggregations"]["by_authors"]["buckets"]
        #   authors_key.each do |key|
        #     @author_import_facet << key[:key]
        #   end 
        #   text_facet[3] = @author_import_facet
        # end

        ################ textfacet processing ################
        # puts text_facet.inspect

        if text_facet[2].length == 0 && text_facet[3].length == 0 && text_facet[0].length != 0 && text_facet[1].length != 0
          puts "ALLLLLLLLLLLLLLLLLLLLLLLLL"
          @data   = Article.article_search_without_keyword_author(text_search,text_facet,page)
          @amount = Article.article_search_without_keyword_author(text_search,text_facet,page).results.total
          # @data_facet     = Article.article_search(text_search,page)
          @journals_facet = @data.response["aggregations"]["by_journal"]["buckets"]
          @years_facet    = @data.response["aggregations"]["by_year"]["buckets"]
          @keywords_facet = @data.response["aggregations"]["by_keywords"]["buckets"]
          @authors_facet  = @data.response["aggregations"]["by_authors"]["buckets"]
          @response = { data: @data, 
                        amount: @amount,
                        journals_facet: @journals_facet,
                        years_facet: @years_facet,
                        keywords_facet: @keywords_facet,
                        authors_facet: @authors_facet
                      }
        elsif text_facet[2].length != 0 && text_facet[3].length != 0
          puts "FULL"
          @data   = Article.article_search_all(text_search,text_facet,page)
          @amount = Article.article_search_all(text_search,text_facet,page).results.total
          # @data_facet     = Article.article_search(text_search,page)
          @journals_facet = @data.response["aggregations"]["by_journal"]["buckets"]
          @years_facet    = @data.response["aggregations"]["by_year"]["buckets"]
          @keywords_facet = @data.response["aggregations"]["by_keywords"]["buckets"]
          @authors_facet  = @data.response["aggregations"]["by_authors"]["buckets"]
          @response = { data: @data, 
                        amount: @amount,
                        journals_facet: @journals_facet,
                        years_facet: @years_facet,
                        keywords_facet: @keywords_facet,
                        authors_facet: @authors_facet
                      }
        elsif text_facet[2].length != 0 && text_facet[3].length == 0
          puts "BBBBBBBBBBBBBBBBBB"
          @data   = Article.article_search_without_keywords(text_search,text_facet,page)
          @amount = Article.article_search_without_keywords(text_search,text_facet,page).results.total
          # @data_facet     = Article.article_search(text_search,page)
          @journals_facet = @data.response["aggregations"]["by_journal"]["buckets"]
          @years_facet    = @data.response["aggregations"]["by_year"]["buckets"]
          @keywords_facet = @data.response["aggregations"]["by_keywords"]["buckets"]
          @authors_facet  = @data.response["aggregations"]["by_authors"]["buckets"]
          @response = { data: @data, 
                        amount: @amount,
                        journals_facet: @journals_facet,
                        years_facet: @years_facet,
                        keywords_facet: @keywords_facet,
                        authors_facet: @authors_facet
                      }
        elsif text_facet[3].length != 0 && text_facet[2].length == 0
          puts "CCCCCCCCCCCCCCCCCCC"
          @data   = Article.article_search_without_authors(text_search,text_facet,page)
          @amount = Article.article_search_without_authors(text_search,text_facet,page).results.total
          # @data_facet = Article.article_search(text_search,page)
          @journals_facet = @data.response["aggregations"]["by_journal"]["buckets"]
          @years_facet    = @data.response["aggregations"]["by_year"]["buckets"]
          @keywords_facet = @data.response["aggregations"]["by_keywords"]["buckets"]
          @authors_facet  = @data.response["aggregations"]["by_authors"]["buckets"]
          # puts @data
          # # puts "#{@data}  ssss #{@journals_facet}"
          # # @journals  = Journal.find(journal_id)
          # # @issues    = @journals.issues.all
          puts @data
          @response = { 
                        data: @data, 
                        amount: @amount,
                        journals_facet: @journals_facet,
                        years_facet: @years_facet,
                        keywords_facet: @keywords_facet,
                        authors_facet: @authors_facet
                      }
        end #endif
        render json: @response
      end
    end
  end
end

# if text_facet[0] != 0 && text_facet[1] == 0 && text_facet[2] == 0 && text_facet[3] == 0
  
# end