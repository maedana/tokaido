import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todos"
export default class extends Controller {
  static targets = ['todoList']
  static values = { todoListKeys: Array }

  connect() {
    this.currentTodoListIndex = 0
  }

  moveDown() {
    this._currentTodoListController()?.moveDown()
  }

  moveUp() {
    this._currentTodoListController()?.moveUp()
  }

  moveRight() {
    if (document.activeElement !== document.querySelector('body')) {
      const todoLists = this.todoListTargets
      this.currentTodoListIndex = (todoLists[this.currentTodoListIndex + 1] ? this.currentTodoListIndex + 1 : 0)
    }
    this._currentTodoListController()?.focus()
  }

  moveLeft() {
    if (document.activeElement !== document.querySelector('body')) {
      const todoLists = this.todoListTargets
      this.currentTodoListIndex = (todoLists[this.currentTodoListIndex - 1] ? this.currentTodoListIndex - 1 : todoLists.length - 1)
    }
    this._currentTodoListController()?.focus()
  }

  openLink() {
    this.focusedTodo.querySelector('a')?.click()
  }

  // focusinならバブリングするので、todoにフォーカスがあたったときの処理をフックしている
  // フォーカス位置のindexを再セットしている。キーボード操作とマウスクリックで現在値を合わせるための処置
  resetActiveTodoListIndex() {
    const activeFocusManagerController = this.application.getControllerForElementAndIdentifier(document.activeElement, 'todo-focus-manager')
    const activeListKey = activeFocusManagerController?.listKeyValue
    this.currentTodoListIndex = this.todoListKeysValue.findIndex((key) => key === activeListKey) || 0
  }

  _currentTodoListController() {
    return this.application.getControllerForElementAndIdentifier(this.todoListTargets[this.currentTodoListIndex], 'todo-list')
  }
}
