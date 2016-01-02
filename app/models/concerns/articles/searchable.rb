module Articles
  module Searchable
    extend ActiveSupport::Concern
    included do
      def self.article_search(text_search,page)
        __elasticsearch__.search(
          {
           from: (page-1)*20 ,size: 20,
            query: {
              multi_match: {
                query: text_search,
                type: "phrase_prefix",
                fields: ['article_name_th','article_name_eng']
              }
            }
          }
        )
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