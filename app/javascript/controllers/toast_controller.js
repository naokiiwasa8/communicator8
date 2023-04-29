import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toast"
export default class extends Controller {
  connect() {
    this.element.style.transform = 'translateY(-100%)';
    setTimeout(() => {
      this.slideIn();
    }, 10);

    const toast = new bootstrap.Toast(this.element, { delay: 3800, autohide: false });
    toast.show();

    setTimeout(() => {
      this.slideOut(() => {
        toast.hide();
      });
    }, 5000);
  }

  slideIn() {
    this.element.style.transition = 'transform 0.5s ease-in-out';
    this.element.style.transform = 'translateY(0)';
  }

  slideOut(callback) {
    this.element.style.transition = 'transform 0.5s ease-in-out';
    this.element.style.transform = 'translateY(-200%)';
    setTimeout(() => {
      if (callback) {
        callback();
      }
    }, 1000);
  }
}
