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

  moveRight() {
    const focusedTodo = this.element.querySelector('.js-todo:focus')
    const todoLists = this.element.querySelectorAll('.js-todos')
    const currentTodoList = focusedTodo.closest('.js-todos')
    const currentTodoListIndex = Array.from(todoLists).findIndex((item) => item === currentTodoList)
    const nextTodoList = todoLists[currentTodoListIndex + 1] || todoLists[0]
    const nextFocusTodo = nextTodoList.querySelector('.js-todo')
    nextFocusTodo.focus()
  }
}
