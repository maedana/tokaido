import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todos"
export default class extends Controller {
  static targets = ['todoList', 'todo']

  connect() {
    this.focusedElementsByTodos = []
    this.focusedTodo = this.todoTarget
    this.focusedTodo?.focus() // デフォルトで最初のTodoにフォーカス
    this.currentTodoListIndex = 0
    this.firstTodoInLists = this.todoTargets.filter((element) => {
      return element.dataset.isFirstInList === 'true'
    })
  }

  moveDown() {
    this._focus(this.focusedTodo.nextElementSibling)
  }

  moveUp() {
    this._focus(this.focusedTodo.previousElementSibling)
  }

  moveRight() {
    const todoLists = this.todoListTargets
    this.focusedElementsByTodos[this.currentTodoListIndex] = this.focusedTodo
    const nextTodoListIndex = todoLists[this.currentTodoListIndex + 1] ? this.currentTodoListIndex + 1 : 0
    const nextFocusTodo = this.focusedElementsByTodos[nextTodoListIndex] || this.firstTodoInLists[nextTodoListIndex]
    this.currentTodoListIndex = nextTodoListIndex
    this._focus(nextFocusTodo)
  }

  // MEMO: moveRightとほぼ同じDRYにしたいところ
  moveLeft() {
    const todoLists = this.todoListTargets
    this.focusedElementsByTodos[this.currentTodoListIndex] = this.focusedTodo
    const nextTodoListIndex = todoLists[this.currentTodoListIndex - 1] ? this.currentTodoListIndex - 1 : todoLists.length - 1
    const nextFocusTodo = this.focusedElementsByTodos[nextTodoListIndex] || this.firstTodoInLists[nextTodoListIndex]
    this.currentTodoListIndex = nextTodoListIndex
    this._focus(nextFocusTodo)
  }

  openLink() {
    this.focusedTodo.querySelector('a')?.click()
  }

  editMemo() {
    const form = this.focusedTodo.querySelector('form.js-todo-edit-form')
    form.requestSubmit()
  }

  _focus(focusCandidate) {
    if (this.todoTargets.includes(focusCandidate)) {
      this.focusedTodo = focusCandidate
      this.focusedTodo.focus()
      // タイトル部分がstickyで上までスクロールしきらないのを補正
      if (this.focusedTodo.dataset.isFirstInList === 'true') {
        this.todoListTargets[this.currentTodoListIndex].scrollTop = 0
      }
    }
  }
}
