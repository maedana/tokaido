import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todo-list"
export default class extends Controller {
  static targets = ['todo']

  connect() {
    this.activeTodoIndex = 0
  }

  moveDown() {
    if (this.activeTodoIndex < (this.todoTargets.length - 1)) {
      this.activeTodoIndex += 1
    }
    this.focus()
  }

  moveUp() {
    if (this.activeTodoIndex > 0) {
      this.activeTodoIndex -= 1
    }
    this.focus()
  }

  focus() {
    this.todoTargets[this.activeTodoIndex]?.focus()
  }

  // focusinならバブリングするので、todoにフォーカスがあたったときの処理をフックしている
  // フォーカス位置のindexを再セットしている。キーボード操作とマウスクリックで現在値を合わせるための処置
  resetActiveTodoIndex() {
    const activeTodoIndex = this.todoTargets.findIndex((element) => element == document.activeElement)
    if (activeTodoIndex >= 0) {
      this.activeTodoIndex = activeTodoIndex
    }
    // タイトル部分がstickyで上までスクロールしきらないのを補正
    if (this.activeTodoIndex === 0) {
      this.element.scrollTop = 0
    }
  }
}
