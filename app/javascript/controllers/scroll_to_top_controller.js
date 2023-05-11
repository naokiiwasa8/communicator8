import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll-to-top"
export default class extends Controller {
  scrollToTop(event) {
    window.scrollTo({ top: 0, behavior: "smooth" });
  }
}