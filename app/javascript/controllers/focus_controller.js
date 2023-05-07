import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="focus"
export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.focusInput();
  }

  focusInput() {
    this.inputTarget.focus();
  }
}