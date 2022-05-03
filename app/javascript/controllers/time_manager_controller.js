import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="time-manager"
export default class extends Controller {
  static values = {
    elapsedTime: Number,
  }
  static targets = ['elapsedTime']

  connect() {
    this.elapsedTimeTarget.textContent = this.elapsedTimeValue
  }
}
