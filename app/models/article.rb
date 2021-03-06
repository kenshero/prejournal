class Article < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Articles::Searchable
  include Articles::Mapping

  include Validator::Customvalid

  belongs_to :issue
  has_many :article_authors, dependent: :destroy
  has_many :authors, through: :article_authors
  before_create :to_cut_whitespace ,:check_have_author
  before_update :to_cut_whitespace ,:check_have_author

  validates :article_name, :presence => true
  # validates :pdf_path, :presence => true
  # validates :keywords, :presence => true ,if: :authors_keywords_not_empty?
  # validates :author_name, :presence => true ,if: :authors_keywords_not_empty?
  # after_update  :map_role_author
  # after_initialize :filter_author_names
  # after_update :filter_author_names
  # accepts_nested_attributes_for :article_authors, 
  #                               reject_if: lambda { |l| l[:authortype].blank?  }, 
  #                               allow_destroy: true
  
  def to_cut_whitespace
    cut_whitespace(keywords)
    cut_whitespace(author_name)
  end

  def check_have_author
    author_name.each do |name|
      have_author = Author.find_or_create_by(author_name: name)
    end
  end

  def update_authors_role(author_role)
    puts author_role.inspect
    author = self.article_authors
    count = 0
    if author_role.nil? || self.author_name.length == 0
    else
      author_role.each do |key, value |
        if author[count].nil?
        else
          author[count].authortype = author_role[key]
          author[count].save
          count = count + 1
        end
      end
    end
  end

  def update_keywords_role(keywords_role)
    self.keywords_role = []
    keywords_role.each do |key, value |
      self.keywords_role << value
    end
    self.save
  end

  def authors_keywords_not_empty?
    cut_whitespace(keywords)
    cut_whitespace(author_name)
  end

  def encode_tis(journal_encode,year,issue,article_encode)

    journal_encode = Iconv.conv('TIS-620', 'utf-8', journal_encode)
    year  = Iconv.conv('TIS-620', 'utf-8', year)
    issue = Iconv.conv('TIS-620', 'utf-8', issue)
    article_encode = Iconv.conv('TIS-620', 'utf-8', article_encode)

    journal_encode = URI.escape(journal_encode, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    article_encode = URI.escape(article_encode, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))

    self.pdf_path = journal_encode+"/"+year+"/"+issue+"/"+article_encode
    puts "#{pdf_path}   ddddddd"

    return self.pdf_path
  end

end