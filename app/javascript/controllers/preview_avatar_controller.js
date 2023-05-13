import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="preview-avatar"

export default class extends Controller {
  static targets = [ "input", "img" ]

  connect() {
    this.inputTarget.addEventListener('change', () => this.preview())
  }

  preview() {
    let reader = new FileReader()
    reader.onloadend = () => {
      this.imgTarget.src = reader.result
    }
    reader.readAsDataURL(this.inputTarget.files[0])
  }
}
