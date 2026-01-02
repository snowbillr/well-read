import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results", "form", "title", "author", "isbn", "totalPages", "coverUrl", "coverPreview"]

  search() {
    clearTimeout(this.timeout)
    const query = this.inputTarget.value.trim()

    if (query.length < 3) {
      this.resultsTarget.src = ""
      this.resultsTarget.innerHTML = ""
      return
    }

    this.timeout = setTimeout(() => {
      const url = new URL(this.data.get("url"), window.location.origin)
      url.searchParams.append("query", query)
      this.resultsTarget.src = url.toString()
    }, 400)
  }

  select(event) {
    const data = event.currentTarget.dataset
    
    this.titleTarget.value = data.bookTitle || ""
    this.authorTarget.value = data.bookAuthor || ""
    this.isbnTarget.value = data.bookIsbn || ""
    this.totalPagesTarget.value = data.bookTotalPages || ""
    this.coverUrlTarget.value = data.bookCoverUrl || ""
    
    if (this.hasCoverPreviewTarget) {
      if (data.bookCoverUrl) {
        this.coverPreviewTarget.src = data.bookCoverUrl
        this.coverPreviewTarget.classList.remove("hidden")
      } else {
        this.coverPreviewTarget.src = ""
        this.coverPreviewTarget.classList.add("hidden")
      }
    }

    this.resultsTarget.src = ""
    this.resultsTarget.innerHTML = ""
    this.inputTarget.value = ""
  }
}
