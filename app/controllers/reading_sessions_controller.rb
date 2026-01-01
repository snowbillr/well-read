class ReadingSessionsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @session = @book.reading_sessions.create!(start_time: Time.current)
    
    respond_to do |format|
      format.turbo_stream
    end
  end

  def update
    @session = ReadingSession.find(params[:id])
    @book = @session.book

    if params[:stop]
      # Stop the timer
      duration = (Time.current - @session.start_time).to_i
      @session.update(duration_seconds: duration)
      
      render :stop
    else
      # Complete the session with page update
      new_page = params[:book][:current_page].to_i
      pages_read = new_page - @book.current_page
      
      # Basic validation/logic check
      pages_read = 0 if pages_read < 0

      ActiveRecord::Base.transaction do
        @session.update!(pages_read: pages_read)
        @book.update!(current_page: new_page)
        
        # Check for completion
        if @book.current_page >= @book.total_pages
          @book.update!(status: :completed, finished_at: Time.current)
        end
      end
      
      render :finish
    end
  end
end