class Book < ApplicationRecord
  has_many :reading_sessions, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true
  validates :total_pages, presence: true, numericality: { greater_than: 0 }
  validates :current_page, numericality: { greater_than_or_equal_to: 0 }

  enum :status, {
    want_to_read: "want_to_read",
    currently_reading: "currently_reading",
    completed: "completed",
    dnf: "dnf"
  }, default: "want_to_read"

  def total_minutes_read
    reading_sessions.sum(:duration_seconds) / 60.0
  end

  def ppm
    return 0 if total_minutes_read.zero?
    
    total_pages_read_sessions = reading_sessions.sum(:pages_read)
    (total_pages_read_sessions / total_minutes_read).round(2)
  end

  def average_session_duration
    return 0 if reading_sessions.count.zero?
    (reading_sessions.average(:duration_seconds) / 60.0).round(1)
  end
  
  def estimated_completion_time
    remaining = total_pages - current_page
    return 0 if remaining <= 0
    
    rate = ppm
    return nil if rate.zero?
    
    (remaining / rate).round # Minutes
  end
end