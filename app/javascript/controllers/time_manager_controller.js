import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="time-manager"
export default class extends Controller {
  static values = {
    elapsedTime: Number,
  }
  static targets = ['elapsedTime', 'elapsedTimeField', 'saveForm']

  connect() {
    this.timeout = null
  }

  startCountTime() {
    clearTimeout(this.timeout)
    if (this.element == document.activeElement) {
      this.elapsedTimeValue += 1
      this.elapsedTimeTarget.textContent = this.elapsedTimeValue
      this.elapsedTimeFieldTarget.value = this.elapsedTimeValue
    }
    this.timeout = setTimeout(() => { this.startCountTime() }, 1000)
  }

  stopCountTime() {
    clearTimeout(this.timeout)
    this.saveFormTarget.requestSubmit()
  }
}
