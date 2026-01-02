class HomeController < ApplicationController
  def index
    @books = Book.currently_reading.order(updated_at: :desc)

    # Calculate Overall Stats
    @total_books_completed = Book.completed.count
    @total_pages_read = ReadingSession.sum(:pages_read)
    
    total_seconds = ReadingSession.sum(:duration_seconds)
    @total_hours_read = (total_seconds / 3600.0).round(1)
    
    total_minutes = total_seconds / 60.0
    @total_ppm = total_minutes > 0 ? (@total_pages_read / total_minutes).round(2) : 0

    avg_seconds = ReadingSession.average(:duration_seconds)
    @avg_session_minutes = avg_seconds ? (avg_seconds / 60).round : 0

    @current_streak = calculate_streak

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

  private

  def calculate_streak
    sessions = ReadingSession.order(start_time: :desc).pluck(:start_time).map(&:to_date).uniq
    return 0 if sessions.empty?

    today = Date.current
    yesterday = today - 1.day
    last_read = sessions.first

    # Streak is broken if not read today or yesterday
    return 0 unless [today, yesterday].include?(last_read)

    streak = 1
    # Check consecutive days
    sessions.each_cons(2) do |current, previous|
      if previous == current - 1.day
        streak += 1
      else
        break
      end
    end

    streak
  end
end
