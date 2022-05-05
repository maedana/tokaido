import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todo-focus-manager"
export default class extends Controller {
  static values = {
    listKey: String,
    uuid: String,
  }

  connect() {
    const lastFocusListKey = window.sessionStorage.getItem('focusListKey', this.listKeyValue)
    const lastFocusUuid = window.sessionStorage.getItem('focusUuid', this.uuid)
    // フォーカスがまだあたっておらず、前回保存値と一致していればフォーカスする
    // (フォーカスがないときはdocument.activeElementはbodyになっている)
    if (document.activeElement === document.querySelector('body') && lastFocusListKey === this.listKeyValue && lastFocusUuid === this.uuidValue) {
      this.element.focus()
    }
  }

  saveFocus() {
    window.sessionStorage.setItem('focusListKey', this.listKeyValue)
    window.sessionStorage.setItem('focusUuid', this.uuidValue)
  }
}
