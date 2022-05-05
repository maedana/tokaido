import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todo-focus-manager"
export default class extends Controller {
  static values = {
    listKey: String,
    uuid: String,
  }

  connect() {
  }
}
