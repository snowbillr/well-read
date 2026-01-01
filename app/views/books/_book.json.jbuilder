json.extract! book, :id, :title, :author, :total_pages, :current_page, :isbn, :status, :rating, :review_text, :started_at, :finished_at, :created_at, :updated_at
json.url book_url(book, format: :json)
