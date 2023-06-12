json.extract! job_site, :id, :name, :url, :description, :created_at, :updated_at
json.url job_site_url(job_site, format: :json)
