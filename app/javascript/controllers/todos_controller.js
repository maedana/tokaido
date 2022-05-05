import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todos"
export default class extends Controller {
  static targets = ['todoList']

  connect() {
    this.currentTodoListIndex = 0
    this._currentTodoListController()?.focus()
  }

  moveDown() {
    this._currentTodoListController()?.moveDown()
  }

  moveUp() {
    this._currentTodoListController()?.moveUp()
  }

  moveRight() {
    const todoLists = this.todoListTargets
    this.currentTodoListIndex = (todoLists[this.currentTodoListIndex + 1] ? this.currentTodoListIndex + 1 : 0)
    this._currentTodoListController()?.focus()
  }

  moveLeft() {
    const todoLists = this.todoListTargets
    this.currentTodoListIndex = (todoLists[this.currentTodoListIndex - 1] ? this.currentTodoListIndex - 1 : todoLists.length - 1)
    this._currentTodoListController()?.focus()
  }

  openLink() {
    this.focusedTodo.querySelector('a')?.click()
  }

  _currentTodoListController() {
    return this.application.getControllerForElementAndIdentifier(this.todoListTargets[this.currentTodoListIndex], 'todo-list')
  }
}
