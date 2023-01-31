import { Controller } from "@hotwired/stimulus"

// hello_controller.js
export default class extends Controller {
  static targets = [ "name", "output" ]

  greet() {
    this.outputTarget.textContent =
      `Hello, ${this.nameTarget.value}!`
  }
}


// export default class extends Controller {
//   connect() {
//     this.element.textContent = "Hello World!"
//   }
// }
