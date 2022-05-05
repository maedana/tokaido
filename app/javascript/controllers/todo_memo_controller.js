import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todo-memo"
export default class extends Controller {
  static targets = ['openForm']

  connect() {
  }

  open() {
    this.timeout = setTimeout(() => {
      this.openFormTarget.requestSubmit()
    }, 500)
  }

  cancel() {
    clearTimeout(this.timeout)
  }
}
