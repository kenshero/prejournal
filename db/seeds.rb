# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# open("/home/kenshero/journals_filter.txt") do |journals|
#   journals.read.each_line do |journal|
#     words = journal
#     puts "#{words}"
#     # Journal.order("id ASC").each do |journal|
#     # end
#   end
# end

# open("/home/kenshero/journals_filter.txt") do |journals|
#   start = Time.now
#   journals.read.each_line do |journal|
#     words = journal
#     puts "#{words}"
#     Journal.create!(journal_name: words)
#   end
#   # code to time
#   finish = Time.now
#   diff = finish - start
#   puts "Difference Time : #{diff}"
# end

# open("/home/kenshero/journal_year.txt") do |issues|
#   issues.read.each_line do |issue|
#     words = issue.split("|")
#     id_issue = words[0]
#     year     = words[2]
#     journal_id = words[1]
#     puts "#{id_issue} .... #{year} .... #{journal_id}"
#     Issue.create!(id: id_issue,
#                   year: year,
#                   journal_id: journal_id)
#   end
# end

# count = 0;
# open("/home/kenshero/journal_article.txt") do |articles|
#   articles.read.each_line do |article|
#     words = article.split("|")
#     count = count + 1
#     article_name_th  = words[2]
#     issue_id = words[0]
#     puts "#{count} .... #{article_name_th} .... #{issue_id}"
#     Article.create!(id: count,
#                     article_name_th: article_name_th,
#                     article_name_eng: article_name_th,
#                     issue_id: issue_id)
#   end
# end

# open("/home/kenshero/journal_author.txt") do |articles|
#   articles.read.each_line do |article|
#     id,name = article.split("|")
#     puts "#{id} .... #{name} "
#     Author.create!(id: id,
#                     author_name: name)
#   end
# end

# count = 1;

# open("/home/kenshero/journal_path.txt") do |journals|
#   journals.read.each_line do |journal|
#     path = journal
#     puts "#{path} "
#     find_journal = Journal.find(count)
#     find_journal.journal_name_eng = path
#     find_journal.save
#     count = count + 1
#   end
# end

# Journal.order("id ASC").each do |journal|
#   puts "#{journal.journal_name_eng}"
#   journal.journal_name_eng = nil;
#   journal.save
# end

# Article.order("id ASC").each do |article|
#   puts "#{article.article_name_eng}"
#   article.article_name_eng = nil
#   article.save
# end

# count = 1
# open("/home/kenshero/journal_title.txt") do |journals|
#   journals.read.each_line do |journal|
#     words = journal.split("|")
#     puts "#{words[1]} "
#     find_journal = Journal.find(count)
#     find_journal.journal_name = words[1]
#     find_journal.save
#     count = count + 1
#   end
# end

# @year = 0
# @issue = 0
# @article = 0

## if new file use -3 ##
# open("/home/kenshero/newarticlesv2.txt") do |issues|
#   issues.read.each_line do |issue|
#     words = issue.split("/")
#     if words.length == 2
#       @journal_ref = words[1]
#       @journal_ref = @journal_ref[0...-2]
#       puts "#{@journal_ref.inspect} __ Ref"
#       @year = 1
#       @issue = 0
#       @article = 0
#       # ss
#     elsif words.length == 3
#       @year_ref = words[2]
#       @year_ref = @year_ref[0...-2]
#       puts "#{@year_ref.inspect} __ Ref"
#       @year = 0
#       @issue = 1
#       @article = 0
#     elsif words.length == 4
#       @issue_ref = words[3]
#       @issue_ref = @issue_ref[0...-2]
#       puts "#{@issue_ref.inspect} __ Ref"
#       @year = 0
#       @issue = 0
#       @article = 1
#     end
    
#     if @year == 1
#       if words[0].to_i == 0
#         # puts "No Issue"
#       else
#         # puts @journal_ref
#         words[0] = words[0].strip
#         puts "Yes Year #{words[0].inspect}"
#         id = Journal.find_by(journal_name: @journal_ref)
#         puts id
#         Year.create!(journal_year: words[0],
#                      journal_id: id.id)
#       end
#     elsif @issue == 1
#       if words[0] == "e-journal" || words[0] == "\n"
#         # puts "No Issue"
#       else
#         # puts "   Yes Issue #{words[0]}"
#         number = words[0]
#         number = number.strip
#         puts "#{number.inspect}"
#         id_journal = Journal.find_by(journal_name: @journal_ref)
#         # puts "#{id_journal.inspect}"
#         # puts "#{@year_ref}"
#         id = id_journal.years.find_by(journal_year: @year_ref)
#         # puts "#{id}"
#         Issue.create!(number: number,
#                       year_id: id.id)
#       end
#     elsif @article == 1
#       isPdf =  words[0][words[0].length-5...words[0].length]
#       puts "#{isPdf.inspect}"
#       isPdf = isPdf.strip if isPdf != nil
#       # binding.pry
#       if isPdf == ".pdf"
#         article = words[0][0...-5]
#         number = @issue_ref
#         puts "#{number.inspect}"
#         puts "#{article.inspect}"

#         id_journal = Journal.find_by(journal_name: @journal_ref)
#         id_year    = id_journal.years.find_by(journal_year: @year_ref)
#         id_issue   = id_year.issues.find_by(number: number)
#         # puts "#{id_year}"
#         # puts "#{id_issue}"
#         Article.create!(article_name: article,
#                         issue_id: id_issue.id)
#       else
#         puts "asdas"
#       end
#     end
#   end
# end

# open("/home/kenshero/newkeywords.txt") do |article_keyword|
#   count_article = 0
#   article_keyword.read.each_line do |articlekeyword|
#     article,keyword = articlekeyword.split("/")

#     Article.where(article_name: article).each do |article_point|
#       if article_point.nil?
#         puts "#{article} dont'have "  
#       else
#         # count_article = count_article + 1
#         puts "#{article_point.article_name} ------ #{keyword}"
#         article_point.keywords << keyword
#         article_point.save
#       end
#     end
#     # article_point = Article.find_by(article_name: article)
#     # puts "#{article_point.inspect}"
#   end
#   # puts " Result Count Keyword = #{count_article}"
# end

##########------create author-----------############

# open("/home/kenshero/newauthors.txt") do |article_author|
#   count_article = 0
#   article_author.read.each_line do |articleauthor|
#     article,author,role = articleauthor.split("//")
#       # puts "#{article.inspect}"
#       # article_point = Article.find_by(article_name: article)
#     Article.where(article_name: article).each do |article_point|
#       if article_point.nil?
#         puts "#{article} dont'have "  
#       else
#         count_article = count_article + 1
#         article_point.author_name << author
#         article_point.save
#         puts "#{article_point.inspect}"
#         puts "#{article_point.author_name}"
#       end
#     end
#   end
#   puts " Result Count Author = #{count_article}"
# end

##########-----------------############

### Delete All Keywords in Articles ##

#   @count_article_keyword = 0
# Article.all.each do |article|

#   if article.keywords.count != 0
#     puts "#{article.article_name}"
#     article.keywords = []
#     article.save
#     @count_article_keyword = @count_article_keyword+1
#   end
# end
# puts "Result index : #{@count_article_keyword}"

##########---------------###########

### Delete All Authors in Articles ##

# @count_article_author = 0
# Article.all.each do |article|

#   if article.author_name.count != 0
#     puts "#{article.article_name}"
#     article.author_name = []
#     article.save
#     @count_article_author = @count_article_author+1
#   end
# end
# puts "Result index : #{@count_article_author}"

##########---------------###########

# open("/home/kenshero/Downloads/new/e_journal_author (1).csv") do |authors|
#   authors.read.each_line do |author|
#     id,name = author.gsub(/["|\r\n]/,'').split(";")
#     puts "#{name.inspect}"
#     Author.create!(author_name: name)
#   end
# end

################# Report ####################

######## article_have_keyword_only ##########

# @article_have_keyword = 0
# @article_have_not_keyword = 0
#   @articles = Article.all
#   @articles.each do |article|
#     if article.keywords.length != 0
#       puts "#{article.keywords}"
#       @article_have_keyword = @article_have_keyword + 1
#     else
#       puts "Dont' have"
#       @article_have_not_keyword = @article_have_not_keyword + 1
#     end
#   end
# puts "Article Have Keywords amount #{@article_have_keyword} ."
# puts "Article Have Not Keywords amount #{@article_have_not_keyword} ."

####################################################################

######## article_have_author_only ##########

# @article_have_author = 0
# @article_have_not_author = 0
#   @articles = Article.all
#   @articles.each do |article|
#     if article.author_name.length != 0
#       puts "#{article.author_name}"
#       @article_have_author = @article_have_author + 1
#     else
#       puts "Dont' have"
#       @article_have_not_author = @article_have_not_author + 1
#     end
#   end
# puts "Article Have authors amount #{@article_have_author} ."
# puts "Article Have Not authors amount #{@article_have_not_author} ."

####################################################################

######## article_have_keyword_and_author ##########

# @article_have_keyword_author = 0
# @article_have_not_keyword_author = 0
#   @articles = Article.all
#   @articles.each do |article|
#     if article.author_name.length != 0 && article.keywords.length != 0
#       puts "#{article.author_name}"
#       @article_have_keyword_author = @article_have_keyword_author + 1
#     else
#       puts "Dont' have"
#       @article_have_not_keyword_author = @article_have_not_keyword_author + 1
#     end
#   end
# puts "Article Have authors and keywords amount #{@article_have_keyword_author} ."
# puts "Article Have Not authors and keywords amount #{@article_have_not_keyword_author} ."

####################################################################

####### genearate PDF_PATH ########

article = Article.find(242205)
count = 0
# articles.each do |article|
  journal_name = article.issue.year.journal.journal_name.gsub(/[\n\r]/,'')
  year_name    = article.issue.year.journal_year.gsub(/[\n\r]/,'')
  issue_name   = article.issue.number.gsub(/[\n\r]/,'')

  pdf = journal_name+"/"+year_name+"/"+issue_name+"/"+article.article_name
  puts "#{pdf.inspect} sss"
  puts "#{article.id}"
  article.pdf_path = pdf
  if article.save
    count = count + 1
  end
# end
puts "Result Article #{count}"

##################################

# ###### Counter Amount PDF ########

# @article_have_pdf = 0
# @article_have_not_pdf = 0
#   @articles = Article.all
#   @articles.each do |article|
#     if !article.pdf_path.nil?
#       puts "#{article.pdf_path}"
#       @article_have_pdf = @article_have_pdf + 1
#     else
#       puts "Dont' have"
#       @article_have_not_pdf = @article_have_not_pdf + 1
#     end
#   end
# puts "Article Have pdf_path amount #{@article_have_pdf} ."
# puts "Article Have Not pdf_path amount #{@article_have_not_pdf} ."

# ################################# 