import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todo-list"
export default class extends Controller {
  static targets = ['todo']

  connect() {
    this.currentFocusIndex = 0
  }

  moveDown() {
    if (this.currentFocusIndex < (this.todoTargets.length - 1)) {
      this.currentFocusIndex += 1
    }
    this.focus()
  }

  moveUp() {
    if (this.currentFocusIndex > 0) {
      this.currentFocusIndex -= 1
    }
    this.focus()
  }

  focus() {
    this.todoTargets[this.currentFocusIndex]?.focus()
    // タイトル部分がstickyで上までスクロールしきらないのを補正
    if (this.currentFocusIndex === 0) {
      this.element.scrollTop = 0
    }
  }
}
