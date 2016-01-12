# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# open("/home/kenshero/journal_title.txt") do |journals|
#   journals.read.each_line do |journal|
#     words = journal.split("|")
#     puts "#{words[0]} .... #{words[1]}"
#     Journal.create!(id: words[0],
#                     journal_name_th: words[1],
#                     journal_name_eng: words[1])
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

Journal.order("id ASC").each do |journal|
  puts "#{journal.journal_name_eng}"
  # journal.journal_name_eng = nil;
  # journal.save
end