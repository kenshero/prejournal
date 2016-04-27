module Articles
  module Mapping
    extend ActiveSupport::Concern
      included do
      index_name "#{Rails.env}_prearticles"
      mapping do
          indexes :id, index: :not_analyzed
          indexes :keywords, analyzer: 'thai', index_options: 'offsets',  boost: 9,
          type: 'string' do
            indexes :raw, type: 'string',  index: :not_analyzed 
          end
          indexes :author_name, analyzer: 'thai', index_options: 'offsets',  boost: 10,
          type: 'string' do
            indexes :raw, type: 'string',  index: :not_analyzed 
          end
          indexes :article_name, analyzer: 'thai', index_options: 'offsets',  boost: 10
          indexes :journal_name , analyzer: 'thai', index_options: 'offsets',  boost: 8,
          type: 'string' do
            indexes :raw, type: 'string',  index: :not_analyzed 
          end
          indexes :journal_year, index_options: 'offsets',  boost: 7,
          type: 'string' do
            indexes :raw, type: 'string',  index: :not_analyzed 
          end
          indexes :number, analyzer: 'thai', index_options: 'offsets'
          indexes :name_suggest, type: 'completion'
          # indexes :journal_name_suggest, type: 'completion'
          # indexes :coordinates, type: 'geo_point'
          # indexes :company_number
          # indexes :main_phone_number, type: 'string',  index: :not_analyzed
          # indexes :market_name,  type: 'string'
          # indexes :opening_hours, type: 'nested' do
          #   indexes :periods, type: 'string'
            # indexes :open_now, type: 'string'
            # indexes :weekday_text, type: 'string'
          # end
          # indexes :rating
          # indexes :tags_with_score, type: 'nested' do
          #   indexes :name,  type: 'string'
          #   indexes :score, type: 'float'
          # end
          # indexes :tag_names,    type: 'string'
          # indexes :region_names, type: 'string'
          # indexes :site_ids,     type: 'integer', index: :not_analyzed
          # indexes :region_ids,   type: 'integer', index: :not_analyzed
          # indexes :category_ids, type: 'integer', index: :not_analyzed
          # indexes :tag_ids,      type: 'integer', index: :not_analyzed
      end
    end
  end
end
