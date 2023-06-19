import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="password"
export default class extends Controller {
  static targets = [ "current", "new", "confirm", "submit" ]

  connect() {
    this.checkForm()
  }

  checkForm() {
    if(this.currentTarget.value && this.newTarget.value && this.confirmTarget.value) {
      this.submitTarget.disabled = false
    } else {
      this.submitTarget.disabled = true
    }
  }

  // Add this function to listen for changes on each input field
  inputChanged() {
    this.checkForm()
  }
}
