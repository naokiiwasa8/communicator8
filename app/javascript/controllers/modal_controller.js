import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"

export default class extends Controller {
  static targets = ["modal"];

  open(event) {
    event.preventDefault();
    let modal = new bootstrap.Modal(this.modalTarget);
    modal.show();
  }
  
  close(event) {
    event.preventDefault();
    let modal = bootstrap.Modal.getInstance(this.modalTarget);
    if (modal) {
      modal.hide();
    }
  }
  
}