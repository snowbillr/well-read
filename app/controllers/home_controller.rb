class HomeController < ApplicationController
  def index
    @current_book = Book.currently_reading.order(updated_at: :desc).first
  end
end