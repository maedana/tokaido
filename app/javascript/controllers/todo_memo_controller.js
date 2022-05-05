import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todo-memo"
export default class extends Controller {
  static targets = ['openForm']
  static values = { available: Boolean }

  connect() {
  }

  open() {
    if (this.availableValue) {
      this.timeout = setTimeout(() => {
        this.openFormTarget.requestSubmit()
      }, 500)
    }
  }

  cancel() {
    clearTimeout(this.timeout)
  }
}
