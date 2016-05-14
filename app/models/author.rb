class Author < ActiveRecord::Base
  has_many  :article_authors, dependent: :destroy
  has_many  :articles, through: :article_authors

  validates :author_name, :presence => true
  
  after_initialize :keep_author
  after_update :update_author_article
  after_destroy :delete_author_name_in_article

  def update_author_article
    puts "#{self.author_name.inspect} SSSSSSSSSSSSSSSS"
    puts "#{@old_author.inspect} WWWWWWWWWWWWWWWW"
    articles = Article.where("'#{@old_author}' = ANY (author_name)")
    articles.all.each do |article|
      puts "#{article.author_name }" 
      article.author_name.each_with_index do |name_author,index|
        if name_author == @old_author
          article.author_name[index] = self.author_name 
          puts "#{article.author_name[index]} eieiei"
          if article.save
            puts "#{article.inspect} debgggg"
          else
            puts "asss"
          end
        end
        puts "#{article.inspect} LLLLLLLLLL"
      end
    end
    # puts "#{articles.inspect}"
  end

  def delete_author_name_in_article
    puts "#{self.author_name.inspect} SSSSSSSSSSSSSSSS"
    puts "#{@old_author.inspect} WWWWWWWWWWWWWWWW"
    articles = Article.where("'#{@old_author}' = ANY (author_name)")
    puts "#{articles} kuyyyy"
    articles.all.each do |article|
      puts "#{article.author_name }" 
      article.author_name.delete_if {|arr| arr == @old_author }
      if article.save
        puts "#{article.inspect} debgggg"
      else
        puts "asss"
      end
    end
  end

  def keep_author
    @old_author = self.author_name
  end

end
