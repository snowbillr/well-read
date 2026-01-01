class HomeController < ApplicationController
  def index
    @books = Book.currently_reading.order(updated_at: :desc)
  end
end