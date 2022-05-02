import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todos"
export default class extends Controller {
  connect() {
    this.focusedElementsByTodos = []
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
    this.focusedElementsByTodos[currentTodoListIndex] = focusedTodo
    let nextFocusTodo = this.focusedElementsByTodos[currentTodoListIndex + 1] || todoLists[currentTodoListIndex + 1]?.querySelector('.js-todo')
    if (!nextFocusTodo) {
      nextFocusTodo = this.focusedElementsByTodos[0] || todoLists[0]?.querySelector('.js-todo')
    }
    nextFocusTodo.focus()
  }

  // MEMO: moveRightとほぼ同じDRYにしたいところ
  moveLeft() {
    const focusedTodo = this.element.querySelector('.js-todo:focus')
    const todoLists = this.element.querySelectorAll('.js-todos')
    const currentTodoList = focusedTodo.closest('.js-todos')
    const currentTodoListIndex = Array.from(todoLists).findIndex((item) => item === currentTodoList)
    this.focusedElementsByTodos[currentTodoListIndex] = focusedTodo
    let nextFocusTodo = this.focusedElementsByTodos[currentTodoListIndex - 1] || todoLists[currentTodoListIndex - 1]?.querySelector('.js-todo')
    if (!nextFocusTodo) {
      nextFocusTodo = this.focusedElementsByTodos[0] || todoLists[0]?.querySelector('.js-todo')
    }
    nextFocusTodo.focus()
  }

  copyEditCommand() {
    const focusedTodo = this.element.querySelector('.js-todo:focus')
    const todoId = focusedTodo.dataset.todoId
    if (todoId) {
      const copyText = `nvim /home/maedana/todotxt/todos/${todoId}.md`
      navigator.clipboard.writeText(copyText)
    }
  }
}
