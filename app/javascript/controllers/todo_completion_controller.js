import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todo-completion"
export default class extends Controller {
  static targets = ['completeForm']

  connect() {
  }

  done() {
    this.completeFormTarget.requestSubmit()
  }
}
