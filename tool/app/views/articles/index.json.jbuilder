json.array!(@articles) do |article|
  json.extract! article, :id, :title, :author, :doc_url, :entry_id
  json.url article_url(article, format: :json)
end
