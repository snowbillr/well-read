require "faraday"
require "json"

class GoogleBooksService
  BASE_URL = "https://www.googleapis.com/books/v1/volumes"

  def self.search(query)
    return [] if query.blank?

    response = connection.get do |req|
      req.params["q"] = query
      req.params["maxResults"] = 10
    end

    return [] unless response.success?

    data = JSON.parse(response.body)
    return [] unless data["items"]

    data["items"].map do |item|
      volume_info = item["volumeInfo"]
      {
        title: volume_info["title"],
        author: volume_info["authors"]&.join(", "),
        total_pages: volume_info["pageCount"],
        isbn: extract_isbn(volume_info["industryIdentifiers"]),
        cover_image_url: volume_info["imageLinks"]&.[]("thumbnail")&.gsub("http://", "https://"),
        description: volume_info["description"]
      }
    end
  rescue StandardError => e
    Rails.logger.error "GoogleBooksService Error: #{e.message}"
    []
  end

  private

  def self.connection
    @connection ||= Faraday.new(url: BASE_URL) do |f|
      f.request :url_encoded
      f.adapter Faraday.default_adapter
      
      # Addressing the CRL issue: Some environments have trouble with CRL checks.
      # We try to keep verification on but can tweak SSL options if needed.
      f.ssl[:verify] = true
      
      # If the CRL error persists, we might need to add specific OpenSSL flags 
      # but Faraday doesn't expose CRL flags directly easily.
      # Usually, Faraday/OpenSSL on macOS uses the system store which handles this.
    end
  end

  def self.extract_isbn(identifiers)
    return nil unless identifiers
    isbn_13 = identifiers.find { |id| id["type"] == "ISBN_13" }
    isbn_10 = identifiers.find { |id| id["type"] == "ISBN_10" }
    (isbn_13 || isbn_10)&.[]("identifier")
  end
end