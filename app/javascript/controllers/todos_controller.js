import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todos"
export default class extends Controller {
  connect() {
    const firstTodo = this.element.querySelector('.js-todo')
    firstTodo.focus()
  }

  moveDown() {
    const focusedTodo = this.element.querySelector('.js-todo:focus')
    focusedTodo.nextElementSibling.focus()
  }

  moveUp() {
    const focusedTodo = this.element.querySelector('.js-todo:focus')
    focusedTodo.previousElementSibling.focus()
  }
}
