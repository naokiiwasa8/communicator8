import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toast"
export default class extends Controller {
  connect() {
    new bootstrap.Toast(this.element, { delay: 5000 }).show()
  }
}
