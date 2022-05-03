import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="time-manager"
export default class extends Controller {
  static values = {
    elapsedTime: Number,
  }
  static targets = ['elapsedTime', 'elapsedTimeField', 'saveForm']

  connect() {
    this.elapsedTimeValue = this.elapsedTimeFieldTarget.value
    this.elapsedTimeTarget.textContent = this._humanElapsedTimeValue()
    this.timeout = null
  }

  startCountTime() {
    clearTimeout(this.timeout)
    if (this.element == document.activeElement) {
      this.elapsedTimeValue += 1
      this.elapsedTimeTarget.textContent = this._humanElapsedTimeValue()
      this.elapsedTimeFieldTarget.value = this.elapsedTimeValue
    }
    this.timeout = setTimeout(() => { this.startCountTime() }, 1000)
  }

  stopCountTime() {
    clearTimeout(this.timeout)
    this.saveFormTarget.requestSubmit()
  }

  _humanElapsedTimeValue() {
    const hour = Math.floor(this.elapsedTimeValue / 3600).toString()
    const minutes = Math.floor(this.elapsedTimeValue / 60).toString()
    const seconds = (this.elapsedTimeValue % 60).toString()
    return `${hour.padStart(2, '0')}:${minutes.padStart(2, '0')}:${seconds.padStart(2, '0')}`
  }
}
