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
#     Journal.order("id ASC").each do |journal|
    
#     end
#   end
# end

# open("/home/kenshero/journals_filter.txt") do |journals|
#   journals.read.each_line do |journal|
#     words = journal
#     puts "#{words}"
#     Journal.create!(journal_name: words)
#   end
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

@year = 0
@issue = 0
@article = 0

open("/home/kenshero/ex_articles.txt") do |issues|
  issues.read.each_line do |issue|
    words = issue.split("/")
    if words.length == 2
      @journal_ref = words[1]
      @journal_ref = @journal_ref[0...-2]
      # puts "#{@journal_ref} __ Ref"
      @year = 1
      @issue = 0
      @article = 0
    elsif words.length == 3
      @year_ref = words[2]
      @year_ref = @year_ref[0...-2]
      # puts "#{@year_ref} __ Ref"
      @year = 0
      @issue = 1
      @article = 0
    elsif words.length == 4
      @issue_ref = words[3]
      @issue_ref = @issue_ref[0...-2]
      # puts "#{@issue_ref} __ Ref"
      @year = 0
      @issue = 0
      @article = 1
    end
    
    if @year == 1
      # if words[0].to_i == 0
      #   # puts "No Issue"
      # else
      #   # puts @journal_ref
      #   puts "Yes Year #{words[0]}"
      #   id = Journal.find_by(journal_name: @journal_ref)
      #   puts id.id
      #   Year.create!(journal_year: words[0],
      #                journal_id: id.id)
      # end
    elsif @issue == 1
      # if words[0] == "e-journal"
      #   # puts "No Issue"
      # else
      #   # puts "   Yes Issue #{words[0]}"
      #   number = words[0]
      #   # puts "#{number}" 
      #   id_journal = Journal.find_by(journal_name: @journal_ref)
      #   id = id_journal.years.find_by(journal_year: @year_ref+"\n")
      #   puts id.id
      #   Issue.create!(number: number,
      #                 year_id: id.id)
      # end
    elsif @article == 1
      isPdf =  words[0][words[0].length-5...words[0].length]
      # puts isPdf
      # binding.pry
      if isPdf == ".pdf\n"
        article = words[0][0...-5]
        number = @issue_ref
        puts "#{number}"
        puts "#{article}"
        id_journal = Journal.find_by(journal_name: @journal_ref+"\n")
        id_year    = id_journal.years.find_by(journal_year: @year_ref+"\n")
        id_issue   = id_year.issues.find_by(number: number+"\n")
        Article.create!(article_name: article,
                        issue_id: id_issue.id)
      else
        # puts ""
      end
    end
  end
end