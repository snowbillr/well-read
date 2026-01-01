import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["output"]
  static values = { startTime: Number }

  connect() {
    this.timer = setInterval(() => {
      this.update()
    }, 1000)
    this.update()
  }

  disconnect() {
    clearInterval(this.timer)
  }

  update() {
    const now = new Date().getTime()
    const diff = Math.floor((now - this.startTimeValue) / 1000)
    
    if (diff < 0) return // clock skew protection

    const hours = Math.floor(diff / 3600)
    const minutes = Math.floor((diff % 3600) / 60)
    const seconds = diff % 60

    this.outputTarget.textContent = `${this.pad(hours)}:${this.pad(minutes)}:${this.pad(seconds)}`
  }

  pad(num) {
    return num.toString().padStart(2, "0")
  }
}
