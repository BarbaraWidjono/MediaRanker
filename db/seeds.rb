require 'csv'

WORK_FILE = File.read(Rails.root.join('db', 'seed_data', 'media_seeds.csv'))

WORK = CSV.parse(WORK_FILE, :headers => true)

WORK.each do |row|
  work = Work.new
    work.category = row['category']
    work.title = row['title']
    work.creator = row['creator']
    work.publication_year = row['publication_year']
    work.description = row['description']
    work.save
    puts "#{work.title}"
end
