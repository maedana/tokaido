import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todo-memo"
export default class extends Controller {
  static targets = ['openForm']

  connect() {
  }

  open() {
    this.openFormTarget.requestSubmit()
  }
}
