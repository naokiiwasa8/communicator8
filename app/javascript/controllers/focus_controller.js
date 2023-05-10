import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="focus"
export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.focusInput();
  }

  focusInput() {
    this.inputTarget.focus();

    // キーボードを開くためのキーボードイベントを発生させる
    const event = new KeyboardEvent('keydown', {
      bubbles: true,
      keyCode: 229
    });
    this.inputTarget.dispatchEvent(event);
  }
}
