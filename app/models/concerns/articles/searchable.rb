module Articles
  module Searchable
    extend ActiveSupport::Concern
    included do
      def self.article_search(text_search,page)
        __elasticsearch__.search(
          {
           from: (page-1)*50 ,size: 50,
            query: {
              multi_match: {
                query: text_search,
                type: "phrase_prefix",
                fields: ['article_name','journal_name']
              }
            },
            aggs: {
              by_journal: {
                terms: {
                  field: "journal_name.raw",
                  size: 0
                  }
              },
              by_year:{
                terms: {
                   field: "journal_year.raw",
                   size: 0
                }
              },
              by_keywords:{
                terms: {
                   field: "keywords.raw",
                   size: 0
                }
              }
            } #agg
          }
        )
      end

      def self.article_suggestion(text_search)
        __elasticsearch__.client.suggest(index: Article.index_name, body: {
          suggestions: {
              text: text_search,
              completion: {
                  field: 'name_suggest'
              }
          }
        })
      end

      def self.article_facet(text_search,text_facet,page)
        __elasticsearch__.search(
          {
           from: (page-1)*50 ,size: 50,
            query: {
              filtered: {
                query: {
                  multi_match: {
                    query: text_search,
                    type: "phrase_prefix",
                    fields: ["article_name","journal_name"]
                  }
                }, #query
                filter: {
                  bool: {
                    must: [
                      {
                        terms: {
                          "journal_name.raw": text_facet[0]
                        }
                      },
                      {
                        terms: {
                          "journal_year.raw": text_facet[1]
                        }
                      }
                      # {
                      #   terms: {
                      #     "keywords.raw": text_facet[2]
                      #   }
                      # }
                    ]
                  }
                } #filter
              }
            }
          }
        )
      end

      # def self.article_facet(text_search,text_facet,page)
      #   __elasticsearch__.search(
      #     {
      #      from: (page-1)*50 ,size: 50,
      #       query: {
      #         bool: {
      #           must: [
      #             {
      #               multi_match: {
      #                 query: text_search,
      #                 type: "phrase_prefix",
      #                 fields: ["article_name","journal_name"]
      #               }
      #             },
      #             {
      #               terms: {
      #                 "journal_name.raw": text_facet[0]
      #               }
      #             },
      #             {
      #               terms: {
      #                 "journal_year.raw": text_facet[1]
      #               }
      #             }
      #           ]
      #         }
      #       }
      #     }
      #   )
      # end


      def as_indexed_json(options={})
        @article = {
          article_name: self.article_name,
          keywords: self.keywords
        }

        @issue = {
          number: self.issue.number
        }

        @year = {
          journal_year: self.issue.year.journal_year
        }

        @journal = {
          journal_name: self.issue.year.journal.journal_name
        }

        # binding.pry
        # s
        suggester = {
          name_suggest: {
            input: [
              self.article_name,self.issue.year.journal.journal_name
            ]
          }
        }

        @article_issue = @article.merge(@issue)
        @article_issue_year = @article_issue.merge(@year)
        @result = @article_issue_year.merge(@journal)

        @result.as_json(
          only: [:article_name,:keywords,:journal_name,:number,:journal_year]
        ).merge(suggester)

      end
     end
  end
end

# Doc.__elasticsearch__.client.cluster.health
# Doc.__elasticsearch__.client = Elasticsearch::Client.new host: 'localhost'


# # # # Delete the previous Customers index in Elasticsearch

# Article.__elasticsearch__.client.indices.delete index: Article.index_name rescue nil

# Article.__elasticsearch__.client.indices.create \
#   index: Article.index_name,
#   body: { settings: Article.settings.to_hash, mappings: Article.mappings.to_hash }

# Article.import

# Journal.joins(years: :issues :articles)