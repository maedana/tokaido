import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todos"
export default class extends Controller {
  static targets = ['todoList', 'todo']

  connect() {
    this.focusedElementsByTodos = []
    this.focusedTodo = this.todoTarget
    this.focusedTodo?.focus() // デフォルトで最初のTodoにフォーカス
    this.currentTodoListIndex = 0
  }

  moveDown() {
    this._focus(this.focusedTodo.nextElementSibling)
  }

  moveUp() {
    this._focus(this.focusedTodo.previousElementSibling)
  }

  _focus(focusCandidate) {
    if (focusCandidate) {
      this.focusedTodo = focusCandidate
      this.focusedTodo?.focus()
    }
  }

  moveRight() {
    const focusedTodo = this.element.querySelector('.js-todo:focus')
    const todoLists = this.todoListTargets
    this.focusedElementsByTodos[this.currentTodoListIndex] = focusedTodo
    const nextTodoListIndex = todoLists[this.currentTodoListIndex + 1] ? this.currentTodoListIndex + 1 : 0
    let nextFocusTodo = this.focusedElementsByTodos[nextTodoListIndex] || todoLists[nextTodoListIndex]?.querySelector('.js-todo')
    this.currentTodoListIndex = nextTodoListIndex
    nextFocusTodo.focus()
  }

  // MEMO: moveRightとほぼ同じDRYにしたいところ
  moveLeft() {
    const focusedTodo = this.element.querySelector('.js-todo:focus')
    const todoLists = this.todoListTargets
    this.focusedElementsByTodos[this.currentTodoListIndex] = focusedTodo
    const nextTodoListIndex = todoLists[this.currentTodoListIndex - 1] ? this.currentTodoListIndex - 1 : todoLists.length - 1
    let nextFocusTodo = this.focusedElementsByTodos[nextTodoListIndex] || todoLists[nextTodoListIndex]?.querySelector('.js-todo')
    this.currentTodoListIndex = nextTodoListIndex
    nextFocusTodo.focus()
  }

  openLink() {
    const focusedTodo = this.element.querySelector('.js-todo:focus')
    const link = focusedTodo.querySelector('a')
    if (link) {
      link.click()
    }
  }

  editMemo() {
    const focusedTodo = this.element.querySelector('.js-todo:focus')
    const form = focusedTodo.querySelector('form.js-todo-edit-form')
    form.requestSubmit()
  }
}
