# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
job_sites = [
  { name: "doda", url: "https://doda.jp/" },
  { name: "リクナビネクスト", url: "https://next.rikunabi.com/" },
  { name: "マイナビ転職", url: "https://tenshoku.mynavi.jp/" },
  { name: "エン転職", url: "https://employment.en-japan.com/" },
  { name: "forkwell", url: "https://forkwell.com/" },
  { name: "findy", url: "https://findy-code.io/" },
  { name: "転職ドラフト", url: "https://job-draft.jp/" },
  { name: "wantedly", url: "https://www.wantedly.com/" },
  { name: "Type", url: "https://type.jp/" },
  { name: "Green", url: "https://www.green-japan.com/" },
  { name: "Bizreach", url: "https://www.bizreach.jp/" },
  { name: "Paiza転職", url: "https://paiza.jp/career/" }
]

job_sites.each do |job_site|
  JobSite.create(name: job_site[:name], url: job_site[:url])
end
