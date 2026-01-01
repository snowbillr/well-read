class HomeController < ApplicationController
  def index
    @books = Book.currently_reading.order(updated_at: :desc)
    
    # Only load suggestions if we are in the empty state (or if specifically searching)
    if @books.empty? || params[:query].present?
      @want_to_read_books = Book.want_to_read
      
      if params[:query].present?
        query = "%#{params[:query].downcase}%"
        @want_to_read_books = @want_to_read_books.where("lower(title) LIKE ? OR lower(author) LIKE ?", query, query)
      else
        @want_to_read_books = @want_to_read_books.order(created_at: :desc).limit(5)
      end
    else
      @want_to_read_books = []
    end
  end
end
