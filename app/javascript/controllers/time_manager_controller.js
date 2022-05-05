import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="time-manager"
export default class extends Controller {
  static values = {
    elapsedTime: Number,
  }
  static targets = ['elapsedTime', 'elapsedTimeField', 'saveForm']

  connect() {
  }

  elapsedTimeFieldTargetConnected() {
    this.elapsedTimeValue = this.elapsedTimeFieldTarget.value
    this.elapsedTimeTarget.textContent = this._humanElapsedTimeValue()
  }

  startCountTime() {
    this.timeout = setTimeout(() => {
      // MEMO: Web Workerを使って工夫しないとバックグランドで時間計測が止まってしまう(setTimeoutやsetIntervalを直接使うとバックグランドでは動作しないので、Workerに逃がしている)
      this.worker = new Worker('/time_worker.js')
      this.worker.postMessage({})
      this.worker.onmessage = () => {
        if (this.element === document.activeElement) {
          this.elapsedTimeValue += 1
          this.elapsedTimeTarget.textContent = this._humanElapsedTimeValue()
          this.elapsedTimeFieldTarget.value = this.elapsedTimeValue
          this.saveFormTarget.requestSubmit()
        }
        this.worker.postMessage({})
      }
    }, 1000) // フォーカスしてから1秒以上経過して初めて記録でいい。
  }

  stopCountTime() {
    clearTimeout(this.timeout)
    // アプリ切り替え以外のフォーカス移動ならworker止めたい
    // アプリ切り替えならactiveElementは自分のままなのでバックグラウンドで動かし続けたい
    if (this.element !== document.activeElement) {
      this.worker?.terminate()
    }
  }

  _humanElapsedTimeValue() {
    const hour = Math.floor(this.elapsedTimeValue / 3600).toString()
    const minutes = Math.floor((this.elapsedTimeValue - hour * 3600) / 60).toString()
    const seconds = (this.elapsedTimeValue % 60).toString()
    return `${hour.padStart(2, '0')}:${minutes.padStart(2, '0')}:${seconds.padStart(2, '0')}`
  }
}
