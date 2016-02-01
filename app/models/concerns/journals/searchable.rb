module Journals
  module Searchable
    extend ActiveSupport::Concern
    included do
      def self.journal_search(text_search,page)
        __elasticsearch__.search(
          {
            from: page*20 ,size: 20,
            query: {
              multi_match: {
                query: text_search,
                type: "phrase_prefix",
                fields: ['journal_name']
              }
            }
          }
        )
      end

      def self.journal_back_cart_search(text_search)
        __elasticsearch__.search(
          {
            query: {
              multi_match: {
                query: text_search,
                type: "phrase_prefix",
                fields: ['journal_name']
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
# Journal.__elasticsearch__.client.indices.delete index: Journal.index_name rescue nil

# Journal.__elasticsearch__.client.indices.create \
#   index: Journal.index_name,
#   body: { settings: Journal.settings.to_hash, mappings: Journal.mappings.to_hash }

# Journal.import